<?php

namespace App\Services\User;

use App\Entity\Acteur;
use App\Entity\User;
use App\Exception\AlreadyRessourceExistsException;
use App\Exception\IncorrectRequestException;
use App\Exception\RessourceNotFoundException;
use App\Repository\ActeurRepository;
use App\Repository\UserRepository;
use App\Request\User\ActivateRequest;
use App\Request\User\LoginRequest;
use App\Request\User\RegisterRequest;
use App\Request\User\UpdateRequest;
use App\Services\Helpers\HelperFonction;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use Lexik\Bundle\JWTAuthenticationBundle\Services\JWTTokenManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Constraints\Json;

readonly class UserService implements IUserService
{

    public function __construct(
        private readonly UserPasswordHasherInterface $passwordHasher,
        private readonly EntityManagerInterface $manager,
        private readonly UserRepository $userRepository,
        private readonly JWTTokenManagerInterface $tokenManager,
        private readonly ActeurRepository $acteurRepository,
        private readonly SerializerInterface $serializer,
    )
    {
    }

    public function getByUser(UserInterface $user): ?Acteur
    {
        return $this->acteurRepository->findOneBy(['user' => $user]);
    }

    public function getByEmail(string $email): ?User
    {
        return $this->userRepository->findOneBy(['email' => $email, 'deleted'=> false]);
    }

    public function add(RegisterRequest $userRequest): ?String
    {
        if($this->getByEmail($userRequest->email)){
            throw new AlreadyRessourceExistsException("Cette email est deja associe a un utilisateur");
        }
        if($userRequest->passwordConfirmation !== $userRequest->password)
        {
            throw new IncorrectRequestException("La confirmation du mot de passe n'est pas conforme");
        }
        $user = new User();
        $user->setEmail($userRequest->email)
            ->setPassword(
                $this->passwordHasher->hashPassword(
                    $user,
                    $userRequest->password
                )
            )
            ->setCodeVerification(HelperFonction::generateDigitNumber())
            ->setActive(false)
            ->setRoles(['ROLE_USER']);
        $this->manager->persist($user);
        $acteur =  new Acteur();
        $acteur->setEmail($userRequest->email)
            ->setNom($userRequest->nom)
            ->setPrenoms($userRequest->prenoms)
            ->setNumero($userRequest->numeroTel)
            ->setUser($user);
        $this->manager->persist($acteur);
        $this->manager->flush();

        return json_encode(json_decode($this->serializer->serialize($acteur, 'json'))); 
    }

    public function update(UpdateRequest $updateRequest, int $id): ?String
    {
        $user = $this->userRepository->find($id);
        $acteur = $this->getByUser($user);
         if(!$acteur){
            throw new RessourceNotFoundException("Cette email n'est pas associe a un utilisateur dans la BD");
        }
        $acteur->setNom($updateRequest->nom)
        ->setEmail($updateRequest->email)
        ->setPrenoms($updateRequest->prenoms)
        ->setNumero($updateRequest->numeroTel)
        ->setUpdatedAt(new DateTime('now'));
        //
        $user->setEmail($updateRequest->email)
         ->setUpdatedAt(new DateTime('now'));

        $this->manager->persist($acteur);
        $this->manager->persist($user);
        $this->manager->flush();
        return Json_encode(json_decode($this->serializer->serialize($acteur, 'json')));

    }

    public function delete(int $id): void
    {
        // TODO: Implement delete() method.
    }

    public function login(LoginRequest $loginRequest ): ?String
    {
        $user = $this->getByEmail($loginRequest->email);
        if(!$user){
            throw new RessourceNotFoundException("Cette email n'est pas associe a un utilisateur dans la BD");
        }
        if(!$user->isActive()){
            throw new IncorrectRequestException("Ce compte n'est pas actif");
        }
        if(!$this->passwordHasher->isPasswordValid($user, $loginRequest->password)){
            throw new IncorrectRequestException("Le mot de passe est incorrect");
        }
        $token = $this->tokenManager->create($user);
        $data = [
            'token' => $token,
            'acteur' => json_decode($this->serializer->serialize($this->getByUser($user), 'json'))
        ];
        return json_encode($data);
    }

    public function activate(ActivateRequest $request):?String
    {
        $user = $this->getByEmail($request->email);
        if(!$user){
            throw new RessourceNotFoundException("Cet utilisateur n'existe pas dans la BD");
        }
        if($request->code !== $user->getCodeVerification()){
            throw new IncorrectRequestException("Le code de verification n'est pas correct");
        }
        $user->setActive(true);
        $user->setUpdatedAt(new \DateTime('now'));
        $this->manager->persist($user);
        $this->manager->flush();
        return json_encode(json_decode($this->serializer->serialize($this->getByUser($user), 'json')));
    }
}
