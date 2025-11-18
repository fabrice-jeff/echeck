<?php

namespace App\Controller;

use App\Exception\IncorrectRequestException;
use App\Exception\RessourceNotFoundException;
use App\Services\Account\IAccountService;
use App\Utils\Constants\AppValuesConstants;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Serializer\Exception\ExceptionInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Request\Account\AccountRequest;
use Symfony\Component\HttpFoundation\Response;

#[Route('/api/account')]
class AccountController extends AbstractController
{
    public function __construct(
        private readonly IAccountService $accountService,
        private readonly SerializerInterface $serializer,
        private readonly ValidatorInterface $validator
    )
    {

    }

    #[Route('/{id}/account', name: 'app_account_by_id', methods: ['GET'])]
    public function getById(int $id):JsonResponse
    {
        try {
            $account = $this->accountService->getById($id);
            if(!$account)
            {
                throw new RessourceNotFoundException("This account does not exist");
            }
            return  new JsonResponse([
                'message' => 'Account found',
                'data' => json_decode($this->serializer->serialize($account,'json')),
                'code' => Response::HTTP_OK,
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


    #[Route('/all/by_actor', name: 'app_account_by_actor_id', methods: ['GET'])]
    public function allByActor(): JsonResponse
    {
        try {
            $user = $this->getUser();
            $account = $this->serializer->serialize($this->accountService->allByActor($user), 'json');
            return  new JsonResponse([
                'message' => 'Account found',
                'data' => json_decode($account),
                'code' => Response::HTTP_OK,
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
    #[Route('/all', name:'app_account_all', methods: ['GET'])]
    public function all():JsonResponse
    {
        try{
            $accounts = $this->serializer->serialize($this->accountService->all(), 'json');

            return new JsonResponse([
                'message' => 'List of all accounts',
                'data' => json_decode($accounts),
                'code' => Response::HTTP_OK
            ]);
        }
        catch (ExceptionInterface $e) {
            return new JsonResponse([
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file'=> $e->getTrace(),
            ]);
        }

    }
    #[Route('/add', name:'app_account_add', methods: 'POST')]
    public  function add(Request $request):JsonResponse
    {
        try {
            $json = $request->getContent();
            if($json === "")
            {
                throw new IncorrectRequestException("Corps de la requette mal formee");
            }
            $accountRequest = $this->serializer->deserialize($json, AccountRequest::class, 'json');
            $validation = AppValuesConstants::validation($accountRequest, $this->validator);
            if($validation !== true){
                return new JsonResponse(['errors' => $validation], 400);
            }
            $user = $this->getUser();
            return  new JsonResponse([
                'message' => "Account add Successful",
                'data'=> json_decode($this->serializer->serialize($this->accountService->add($accountRequest, $user), 'json')),
                'code'=> Response::HTTP_CREATED,
            ]);
        }
        catch (ExceptionInterface $e) {
            return new JsonResponse([
                'message' => $e->getMessage(),
                'line' => $e->getLine(),
                'file'=> $e->getTrace(),
            ]);
        }
    }

    #[Route('/{id}/delete', name: 'app_account_delete', methods: ['DELETE'])]
    public function delete(int $id):JsonResponse
    {
        try {
            $this->accountService->delete($id);
            return new JsonResponse([
                'message' => "Account delete Successful",
                'data' => null
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
}
