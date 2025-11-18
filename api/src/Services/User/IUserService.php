<?php

namespace App\Services\User;

use App\Entity\Acteur;
use App\Entity\User;
use App\Request\User\ActivateRequest;
use App\Request\User\LoginRequest;
use App\Request\User\RegisterRequest;
use Symfony\Component\Security\Core\User\UserInterface;

interface IUserService
{
    public function getByUser(UserInterface $user):?Acteur;
    public function getByEmail(string $email):?User;
    public  function add(RegisterRequest $userRequest):?String;
    public function update(RegisterRequest $userRequest, int $id):void;

    public  function delete(int $id):void;
    public function login(LoginRequest $loginRequest):?String;
    public function activate(ActivateRequest $request):?String;

}
