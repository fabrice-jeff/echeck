<?php 
namespace App\Controller;

use App\Entity\Acteur;
use App\Exception\IncorrectRequestException;
use App\Request\User\ActivateRequest;
use App\Request\User\ForgotPasswordRequest;
use App\Request\User\LoginRequest;
use App\Request\User\RegisterRequest;
use App\Request\User\ResetPasswordRequest;
use App\Request\User\ResendCodeRequest;
use App\Request\User\UpdateRequest;
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
use Symfony\Component\HttpKernel\Exception\HttpException;

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
                $this->mailService->send($this->serializer->deserialize($acteur, Acteur::class, 'json'));
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
            ], Response::HTTP_BAD_REQUEST);
        }
        catch(HttpException $exception){
            return new JsonResponse([
                'message' => $exception->getMessage(),
            ], $exception->getStatusCode());
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
            ], Response::HTTP_BAD_REQUEST);
        }
        catch(\Exception $e)
        {
            return new JsonResponse([
                'message' => $e->getMessage(),
                'code' => Response::HTTP_BAD_REQUEST,
            ], Response::HTTP_BAD_REQUEST);
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
            ], Response::HTTP_BAD_REQUEST);
        }
        catch(HttpException $e)
        {
            return new JsonResponse([
                'message' => $e->getMessage(),
            ], $e->getStatusCode());
        }
    }

    #[Route('/resend-code', name: 'app_user_resend_code', methods: ['POST'])]
    public function resendCode(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            if ($json === "") {
                throw new IncorrectRequestException("Corps de requette mal formee");
            }
            $resendRequest = $this->serializer->deserialize($json, ResendCodeRequest::class, 'json');
            $validation = AppValuesConstants::validation($resendRequest, $this->validator);
            if ($validation !== true) {
                return new JsonResponse(['errors' => $validation], 400);
            }
            $acteur = $this->userService->resendCode($resendRequest->email);
            $this->mailService->send($acteur);
            return new JsonResponse([
                'message' => 'Code renvoyé avec succès',
                'code' => Response::HTTP_OK,
            ]);
        } catch (ExceptionInterface $e) {
            return new JsonResponse(['message' => $e->getMessage()], Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            return new JsonResponse(['message' => $e->getMessage()], Response::HTTP_BAD_REQUEST);
        }
    }

    #[Route('/forgot-password', name: 'app_user_forgot_password', methods: ['POST'])]
    public function forgotPassword(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            if ($json === "") {
                throw new IncorrectRequestException("Corps de requette mal formee");
            }
            $forgotRequest = $this->serializer->deserialize($json, ForgotPasswordRequest::class, 'json');
            $validation = AppValuesConstants::validation($forgotRequest, $this->validator);
            if ($validation !== true) {
                return new JsonResponse(['errors' => $validation], 400);
            }
            $acteur = $this->userService->forgotPassword($forgotRequest->email);
            $this->mailService->sendResetPassword($acteur);
            return new JsonResponse([
                'message' => 'Code de réinitialisation envoyé avec succès',
                'code' => Response::HTTP_OK,
            ]);
        } catch (ExceptionInterface $e) {
            return new JsonResponse(['message' => $e->getMessage()], Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            return new JsonResponse(['message' => $e->getMessage()], Response::HTTP_BAD_REQUEST);
        }
    }

    #[Route('/reset-password', name: 'app_user_reset_password', methods: ['POST'])]
    public function resetPassword(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            if ($json === "") {
                throw new IncorrectRequestException("Corps de requette mal formee");
            }
            $resetRequest = $this->serializer->deserialize($json, ResetPasswordRequest::class, 'json');
            $validation = AppValuesConstants::validation($resetRequest, $this->validator);
            if ($validation !== true) {
                return new JsonResponse(['errors' => $validation], 400);
            }
            $this->userService->resetPassword($resetRequest);
            return new JsonResponse([
                'message' => 'Mot de passe réinitialisé avec succès',
                'code' => Response::HTTP_OK,
            ]);
        } catch (ExceptionInterface $e) {
            return new JsonResponse(['message' => $e->getMessage()], Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            return new JsonResponse(['message' => $e->getMessage()], Response::HTTP_BAD_REQUEST);
        }
    }

    #[Route('/update',name: 'app_user_update', methods: ['POST'])]
    public  function update(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            
            if($json === ""){
              throw new IncorrectRequestException("Corps de requette mal formee");
            }
            $updateRequest = $this->serializer->deserialize($json, UpdateRequest::class, 'json');
            $validation = AppValuesConstants::validation($updateRequest, $this->validator);
            if($validation !== true){
                return new JsonResponse(['errors' => $validation], 400);
            }
            ;

            return new JsonResponse([
                'message' => 'User update Success',
                'data' => json_decode($this->userService->update($updateRequest, $updateRequest->id)),
                'code' => Response::HTTP_CREATED
                
            ]);
        }
        catch(ExceptionInterface $e)
        {
            return  new JsonResponse([
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file'=> $e->getTrace(),
            ], Response::HTTP_BAD_REQUEST);
        }
        catch(HttpException $e)
        {
            return new JsonResponse([
                'message' => $e->getMessage(),
            ], $e->getStatusCode());
        }
    }

}
