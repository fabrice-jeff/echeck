<?php

namespace App\Exception;


use Symfony\Component\HttpKernel\Exception\HttpException;
use Symfony\Component\HttpFoundation\Response;

class RessourceNotFoundException extends HttpException
{

    /**
     * @param string $string
     */
    public function __construct(string $message)
    {
        parent::__construct(Response::HTTP_NOT_FOUND,$message);
    }
}
