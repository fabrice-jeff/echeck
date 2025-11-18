<?php

namespace App\Exception;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Symfony\Component\HttpFoundation\Response;

class AlreadyRessourceExistsException extends HttpException
{
    public function __construct(string $message, )
    {
        parent::__construct(Response::HTTP_CONFLICT, $message);
    }
}
