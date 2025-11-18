<?php

namespace App\Services\Cheque;

use App\Repository\ChequeRepository;
use App\Request\Cheque\ChequeRequest;
use App\Services\User\IUserService;
use Symfony\Component\Security\Core\User\UserInterface;

readonly class ChequeService implements IChequeService
{

    public function __construct(
        private readonly ChequeRepository $chequeRepositorty,
        private readonly IUserService $userService
    )
    {
    }

    public function getById(int $id)
    {
        // return $this->id;
    }

    public function allbyActor(UserInterface $user)
    {
        // TODO: Implement allbyActor() method.
    }

    public function all()
    {
        // TODO: Implement all() method.
    }

    public function add(ChequeRequest $request)
    {
        // TODO: Implement add() method.
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
