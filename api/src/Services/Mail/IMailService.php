<?php

namespace App\Services\Mail;

use App\Entity\Acteur;

interface IMailService{
    public function send(Acteur $acteur): void;
    public function sendResetPassword(Acteur $acteur): void;
}