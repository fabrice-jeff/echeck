<?php

namespace App\Services\Cheque;

use App\Entity\Compte;
use App\Request\Cheque\ChequeRequest;
use Symfony\Component\Security\Core\User\UserInterface;


interface IChequeService
{
    public function getById(int $id);
    public function allByActorAndAccount(UserInterface $user, Compte $account);
    public function allByUser(UserInterface $user);

    public function add(ChequeRequest $request, String $uploadDirectory, UserInterface $currentUser);
    public function update(ChequeRequest $request);

    public function delete(int $id);

}
