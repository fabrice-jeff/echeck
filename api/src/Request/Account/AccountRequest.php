<?php

namespace App\Request\Account;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\Constraints as Assert;
class AccountRequest extends Request
{
   
    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $iban;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $bic;

    #[Assert\NotNull]
    #[Assert\Type('integer')]
    public int $banqueId;

    
    // #[Assert\NotNull]
    // #[Assert\Type('float')]
    // public float $amount;

    // #[Assert\NotBlank]
    // #[Assert\Type('string')]
    // public string $dateExpiration;


}
