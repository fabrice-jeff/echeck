<?php

namespace App\Controller;

use App\Entity\Acteur;
use App\Exception\IncorrectRequestException;
use App\Request\User\ActivateRequest;
use App\Request\User\LoginRequest;
use App\Request\User\RegisterRequest;
use App\Services\Mail\IMailService;
use App\Services\User\IUserService;
use App\Utils\Constants\AppValuesConstants;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\Serializer\Exception\ExceptionInterface;

    #[Route('/api/user')]
class UserController extends AbstractController
{
    public function __construct(
        private readonly IUserService $userService,
        private readonly SerializerInterface $serializer,
        private readonly ValidatorInterface $validator,
        private readonly IMailService $mailService
    )
    {
    }

    #[Route('/register',name: 'app_user_register', methods: ['POST'])]
    public function register(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            if($json === ""){
                throw new IncorrectRequestException("Coprs de requette mal formee");
            }
            $registerRequest = $this->serializer->deserialize($json, RegisterRequest::class, 'json');
            $validation = AppValuesConstants::validation($registerRequest, $this->validator);
            if($validation !== true){
                return new JsonResponse(['errors' => $validation], 400);
            }
            else
            {
                $acteur = $this->userService->add($registerRequest);
                /// Emvoi d'un email a l'utilisteur 
                $this->mailService->send($this->serializer->deserialize($acteur, Acteur::class, 'json'), 123456);
                return  new JsonResponse([
                    'message' => 'User add Success',
                    'data' =>json_decode($acteur),
                    'code' => Response::HTTP_CREATED
                ]);
            }

        }
        catch(ExceptionInterface $exception){
            return new JsonResponse([
             'message' => $exception->getMessage(),
             'line' => $exception->getLine(),
             'file'=> $exception->getTrace(),
            ]);
        }
    }
    #[Route('/login',name: 'app_user_login', methods: ['POST'])]
    public  function login(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            
            if($json === ""){
              throw new IncorrectRequestException("Corps de requette mal formee");
            }

            $loginRequest = $this->serializer->deserialize($json, LoginRequest::class, 'json');
            $validation = AppValuesConstants::validation($loginRequest, $this->validator);
            if($validation !== true){
                return new JsonResponse(['errors' => $validation], 400);
            }
            return new JsonResponse([
                'message' => 'User login Success',
                'data' => json_decode($this->userService->login($loginRequest)),
                'code' => Response::HTTP_OK
                
            ]);
        }
        catch(ExceptionInterface $e)
        {
            return  new JsonResponse([
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file'=> $e->getTrace(),
            ]);
        }
    }

    #[Route('/activate', name: 'app_user_activate', methods: ['POST'])]
    public function activate( Request $request):JsonResponse
    {
        try {
            $jsonResponse = $request->getContent();
            if ($jsonResponse === "")
            {
                 throw new IncorrectRequestException("Corps de requette mal formee");
            }
            $activateRequest = $this->serializer->deserialize($jsonResponse, ActivateRequest::class, 'json');
            $validation = AppValuesConstants::validation($activateRequest, $this->validator);
            if($validation !== true){
                return new JsonResponse(['errors' => $validation], 400);
            }
            $this->userService->activate($activateRequest);
            return new JsonResponse([
                'message' => 'User activate Success',
                'data' => json_decode($this->userService->activate($activateRequest)),
                'code' => Response::HTTP_OK
            ]);
        }
        catch(ExceptionInterface $e)
        {
            return new JsonResponse([
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file'=> $e->getTrace(),
            ]);
        }
    }

    // #[Route('/{id}/activate', name: 'app_user_activate', methods: ['GET'])]
    // public function getByEmail( Request $request, int $id):JsonResponse
    // {
    //     try {
    //         $jsonResponse = $request->getContent();
    //         if ($jsonResponse === "")
    //         {
    //              throw new IncorrectRequestException("Coprs de requette mal formee");
    //         }
    //         $activateRequest = $this->serializer->deserialize($jsonResponse, ActivateRequest::class, 'json');
    //         $validation = AppValuesConstants::validation($activateRequest, $this->validator);
    //         if($validation !== true){
    //             return new JsonResponse(['errors' => $validation], 400);
    //         }
    //         $this->userService->activate($activateRequest, $id);
    //         return new JsonResponse([
    //             'message' => 'User activate Success',
    //             'data' => null
    //         ]);
    //     }
    //     catch(ExceptionInterface $e)
    //     {
    //         return new JsonResponse([
    //             'message' => $e->getMessage(),
    //             'line' => $e->getLine(),
    //             'file'=> $e->getTrace(),
    //         ]);
    //     }
    // }

    // #[Route('/{id}/activate', name: 'app_user_activate', methods: ['POST'])]
    // public function getById( Request $request, int $id):JsonResponse
    // {
    //     try {
    //         $jsonResponse = $request->getContent();
    //         if ($jsonResponse === "")
    //         {
    //              throw new IncorrectRequestException("Coprs de requette mal formee");
    //         }
    //         $activateRequest = $this->serializer->deserialize($jsonResponse, ActivateRequest::class, 'json');
    //         $validation = AppValuesConstants::validation($activateRequest, $this->validator);
    //         if($validation !== true){
    //             return new JsonResponse(['errors' => $validation], 400);
    //         }
    //         $this->userService->activate($activateRequest, $id);
    //         return new JsonResponse([
    //             'message' => 'User activate Success',
    //             'data' => null
    //         ]);
    //     }
    //     catch(ExceptionInterface $e)
    //     {
    //         return new JsonResponse([
    //             'message' => $e->getMessage(),
    //             'line' => $e->getLine(),
    //             'file'=> $e->getTrace(),
    //         ]);
    //     }
    // }
}
