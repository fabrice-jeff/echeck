<?php

namespace App\EventListener;
use Symfony\Component\HttpKernel\Event\ExceptionEvent;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

class ExceptionListener
{
    public function onKernelException(ExceptionEvent $event): void
    {
        $exception = $event->getThrowable();

        $statusCode = $exception instanceof HttpExceptionInterface
            ? $exception->getStatusCode()
            : 500;

        $response = new JsonResponse([
            'error' => [
                'message' => $exception->getMessage(),
                'detail' => $exception->getTraceAsString(),
                'code' => $statusCode,
            ]
        ], $statusCode);

        $event->setResponse($response);
    }

}
