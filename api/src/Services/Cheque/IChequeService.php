<?php

namespace App\Services\Cheque;

use App\Request\Cheque\ChequeRequest;
use Symfony\Component\Security\Core\User\UserInterface;


interface IChequeService
{
    public function getById(int $id);
    public function allbyActor(UserInterface $user);
    public function all();

    public function add(ChequeRequest $request);
    public function update(ChequeRequest $request);

    public function delete(int $id);

}
