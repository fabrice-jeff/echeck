<?php

namespace App\Exception;

use Symfony\Component\HttpKernel\Exception\HttpException;
use Symfony\Component\HttpFoundation\Response;

class IncorrectRequestException extends HttpException
{
    public function __construct(string $message)
    {
        parent::__construct(Response::HTTP_BAD_REQUEST,$message);
    }
}
