<?php

namespace App\Request\User;


use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\Constraints as Assert;


class UpdateRequest extends Request
{
     #[Assert\NotNull]
    #[Assert\Type('integer')]
    public int $id;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $nom;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $prenoms;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    #[Assert\Email]
    public string $email;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $numeroTel;
}
