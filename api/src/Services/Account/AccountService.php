<?php

namespace App\Services\Account;

use App\Entity\Compte;
use App\Exception\RessourceNotFoundException;
use App\Repository\CompteRepository;
use App\Request\Account\AccountRequest;
use App\Services\Banque\IBanqueService;
use App\Services\User\IUserService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\User\UserInterface;

readonly class AccountService implements IAccountService
{

    public function __construct(
        private readonly CompteRepository $compteRepository,
        private readonly EntityManagerInterface $manager,
        private readonly IUserService $userService,
        private readonly IBanqueService $banqueService,
    )
    {

    }

    public function getById(int $id): ?Compte
    {
        return $this->compteRepository->findOneBy(['id' => $id, 'deleted' => false]);
    }
    public function getByIban(String $iban): ?Compte
    {
        return $this->compteRepository->findOneBy(['iban' => $iban, 'deleted' => false]);
    }
    public function getByActorAndId(UserInterface $currentUser, int $id):?Compte
    {
        $actor = $this->userService->getByUser($currentUser);
        return $this->compteRepository->findOneBy(['deleted' => false, 'acteur' => $actor, 'id' => $id]);
    }

    public function allByActor(UserInterface $currentUser): mixed
    {
        $actor = $this->userService->getByUser($currentUser);
        return $this->compteRepository->findBy(['deleted' => false, 'acteur' => $actor]);
    }

    public function all(): array
    {
       return $this->compteRepository->findBy(['deleted' => false]);
    }

    public function add(AccountRequest $request, UserInterface $currentUser): ?Compte
    {
        $banque = $this->banqueService->getById($request->banqueId);
        if(!$banque){
            throw new RessourceNotFoundException("Banque not found");
        }
        $account = new Compte();
        // $dateExpiration = new \DateTime($request->dateExpiration);
        $account
            ->setBic($request->bic)
            ->setIban($request->iban)
            ->setAmount(500000) // Par defaut le montant du compte est de 500000 FCFA
            ->setBanque($banque)
            ->setInsertBy($currentUser);

        $this->manager->persist($account);
        $this->manager->flush();
        return $account;
    }

    public function update(AccountRequest $request, UserInterface $currentUser): void
    {
        // TODO: Implement update() method.
    }

    public function delete(int $id): void
    {
        $compte = $this->getById($id);
        if(!$compte)
        {
            throw new RessourceNotFoundException("Compte not found");
        }
        $compte->setDeleted(true);
        $compte->setDeletedAt(new \DateTime('now'));
        $compte->setUpdatedAt(new \DateTime('now'));
        $this->manager->flush();
    }
}
