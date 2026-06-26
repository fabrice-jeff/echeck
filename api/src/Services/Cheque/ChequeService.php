<?php

namespace App\Services\Cheque;

use App\Entity\Cheque;
use App\Entity\Compte;
use App\Exception\RessourceNotFoundException;
use App\Repository\ChequeRepository;
use App\Repository\CompteRepository;
use App\Request\Cheque\ChequeRequest;
use App\Services\User\IUserService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Serializer\SerializerInterface;

readonly class ChequeService implements IChequeService
{

    public function __construct(
        private readonly ChequeRepository $chequeRepositorty,
        private readonly IUserService $userService,
        private readonly CompteRepository $compteRepository,
        private readonly EntityManagerInterface $manager,
        private readonly SerializerInterface $serializer,
    )
    {
    }

    public function getById(int $id)
    {
        // return $this->id;
    }

    public function allByActorAndAccount(UserInterface $user, Compte $account)
    {
         
        $checks = $this->chequeRepositorty->findBy(['deleted' => false, 'compte' => $account,  'insertBy' => $user]);
        return $checks;
        
    }

    public function allByUser(UserInterface $user)
    {
        $checks = $this->chequeRepositorty->findBy(['deleted' => false, 'insertBy' => $user]);
        return $checks;
    }

    public function add(ChequeRequest $request, String $uploadDirectory, UserInterface $currentUser)
    {

       // Rechercher ce compte dans la base de donnee
       $account = $this->compteRepository->findOneBy(['deleted' => false, 'iban' => $request->accountIban]);
       if(!$account){
            throw new RessourceNotFoundException("Cet compte n'existe pas dans la base de donnee");
       }

       // Verifier que le montant du cheque est inferieur ou egal au montant du compte
       if($request->amount > $account->getAmount()){
            throw new RessourceNotFoundException("Le montant du cheque est superieur au montant du compte");
       }

       $account->setAmount($account->getAmount() - $request->amount);
       $this->manager->persist($account);

        // 1. Récupérer les données
        $base64File = $request->file;
        $filename = $request->filename ?? uniqid('pdf_') . '.pdf';
        $fileContent = base64_decode($base64File);
        $fs = new Filesystem();
        
        if (!$fs->exists($uploadDirectory)) {
            $fs->mkdir($uploadDirectory, 0777);
        }
        $filePath = $uploadDirectory . '/' . $filename;

        try {
            file_put_contents($filePath, $fileContent);
         
        } catch (\Exception $e) {
            return new JsonResponse(['error' => 'Erreur lors de l\'écriture du fichier'], 500);
        }

       $cheque = new Cheque();
       $cheque->setNomBenefiaire($request->name)
        ->setPrenomBeneficiaire($request->firstName)
        ->setMontant($request->amount)
        ->setCompte($account)
        ->setObjet($request->object)
        ->setInsertBy($currentUser)
        ->setStatut("NON_ENCIASSE")
        ->setFileUrl($filename);
        $this->manager->persist($cheque);
        $this->manager->flush();

        return json_encode(json_decode($this->serializer->serialize($cheque, 'json'))); 
    }

    public function update(ChequeRequest $request)
    {
        // TODO: Implement update() method.
    }

    public function delete(int $id)
    {
        // TODO: Implement delete() method.
    }
}
