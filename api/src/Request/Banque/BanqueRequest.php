<?php

namespace App\Request\Banque;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\Constraints as Assert;


class BanqueRequest extends Request
{
    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $libelle;


    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $name;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $adressPostal;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $codePostal;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $phone;
    
    
    
}
