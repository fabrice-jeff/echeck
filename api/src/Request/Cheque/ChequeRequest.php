<?php

namespace App\Request\Cheque;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\Constraints as Assert;

class ChequeRequest extends Request
{
    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $nomBeneficiaire;
    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $prenomBeneficiaire;

    #[Assert\NotNull]
    #[Assert\Type('float')]
    public float $montant;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $objet;

    #[Assert\NotBlank]
    #[Assert\Type('string')]
    public string $statut;

    #[Assert\NotNull]
    #[Assert\Type('integer')]
    public int $accountId;

}
