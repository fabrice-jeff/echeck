<?php 

namespace App\Services\Mail;

use App\Entity\Acteur;

interface IMailService{
    public function send(Acteur $acteur):void;
}