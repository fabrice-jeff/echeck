<?php

namespace App\Services\Account;

use App\Entity\Compte;
use App\Request\Account\AccountRequest;
use Symfony\Component\Security\Core\User\UserInterface;

interface IAccountService
{
    public function getById(int $id): ?Compte;
    public function getByIban(String $iban): ?Compte;
    public function getByActorAndId(UserInterface $currentUser, int $id): ?Compte;
    public function allByActor(UserInterface $currentUser):mixed;
    public function all():array;
    public function add(AccountRequest $request, UserInterface $currentUser):?Compte;

    public function update(AccountRequest $request, UserInterface $currentUser):void;
    public function delete(int $id):void;

}
