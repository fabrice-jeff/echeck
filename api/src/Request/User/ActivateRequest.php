<?php

namespace App\Request\User;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\Constraints as Assert;

class ActivateRequest extends Request
{
    #[Assert\NotBlank()]
    #[Assert\Type('string')]
    #[Assert\Email()]
    public string $email;

    #[Assert\NotBlank()]
    #[Assert\Type('string')]
    public string $code;
}
