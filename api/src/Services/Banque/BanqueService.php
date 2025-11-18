<?php

namespace App\Services\Banque;

use App\Entity\Banque;
use App\Exception\AlreadyRessourceExistsException;
use App\Exception\RessourceNotFoundException;
use App\Repository\BanqueRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Banque\BanqueRequest;

class BanqueService implements IBanqueService
{
    public function __construct(
        private readonly EntityManagerInterface $manager,
        private readonly BanqueRepository $banqueRepository
    )
    {
    }

    public function getById(int $id): ?Banque
    {
        return  $this->banqueRepository->findOneBy(['id' => $id, 'deleted' => false]);
    }

    public function getByName(string $name): ?Banque
    {
        return $this->banqueRepository->findOneBy(['libelle' => $name, 'deleted' => false]);
    }
    public function all(): array
    {
        return $this->banqueRepository->findBy(['deleted' => false]);
    }

    public function add(BanqueRequest $request): void
    {
        if ($this->getByName($request->libelle) !== null) {
             throw  new AlreadyRessourceExistsException("Cette banque existe deja");
        }
        $banque = new Banque();
        $banque->setLibelle($request->libelle);
        $this->manager->persist($banque);
        $this->manager->flush();
    }

    public function update(BanqueRequest $request, int $id): void
    {
        $banque = $this->getById($id);
        if ($banque === null) {
            throw new RessourceNotFoundException("Cette banque n'existe pas");
        }
        $banque->setLibelle($request->libelle);
        $this->manager->flush();
    }

    public function delete(int $id): void
    {
        $banque = $this->getById($id);
        if ($banque === null) {
           throw new RessourceNotFoundException("Cette banque n'existe pas");
        }
        $banque->setDeleted(true);
        $this->manager->flush();
    }

}
