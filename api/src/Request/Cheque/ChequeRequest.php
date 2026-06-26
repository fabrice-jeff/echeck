<?php

namespace App\Request\Cheque;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\Constraints as Assert;

class ChequeRequest extends Request
{
    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $name;
    
    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $firstName;

    #[Assert\NotNull]
    #[Assert\Type('float')]
    public float $amount;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $object;

    #[Assert\NotNull]
    #[Assert\Type('string')]
    public string $accountIban;

    #[Assert\NotNull]
    #[Assert\Type('string')]
    public string $file;
    
    #[Assert\NotNull]
    #[Assert\Type('string')]
    public string $fileName;

      #[Assert\NotNull]
    #[Assert\Type('string')]
    public string $extension;



}
