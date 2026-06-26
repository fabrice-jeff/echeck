<?php

namespace App\Controller;

use App\Exception\IncorrectRequestException;
use App\Exception\RessourceNotFoundException;
use App\Request\Cheque\ChequeRequest;
use App\Services\Account\IAccountService;
use App\Services\Cheque\IChequeService;
use App\Utils\Constants\AppValuesConstants;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\DependencyInjection\Exception\ExceptionInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

#[Route('/api/cheque')]
class ChequeController extends AbstractController
{   
    public function __construct(
        private readonly IAccountService $accountService,
        private readonly SerializerInterface $serializer,
        private readonly ValidatorInterface $validator,
        private readonly IChequeService $chequeService
    )
    {
    }

    #[Route('/add',name: 'app_cheque_add', methods: ['POST'])]
    public function add(Request $request):JsonResponse
    {

        try{
            $user = $this->getUser();
            $json = $request->getContent();
            if($json === "")
            {
                throw new IncorrectRequestException("Corps de la requette mal formee");
            }
            $chequeRequest = $this->serializer->deserialize($json, ChequeRequest::class, 'json');
            $validation = AppValuesConstants::validation($chequeRequest, $this->validator);
            if($validation !== true){
                return new JsonResponse(['errors' => $validation], 400);
            }
            
            return  new JsonResponse([
                'message' => 'Cheque create Successful',
                'data' => json_decode($this->chequeService->add($chequeRequest, $this->getParameter('uploads_directory'), $user)),
                'code' => Response::HTTP_CREATED 
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


    #[Route('/all/by_actor_and_account/{accountId}',name: 'app_cheque_all_by_actor_and_account', methods: ['GET'])]
    public function allbyActorAndAccount(int $accountId):JsonResponse
    {

        try {
            $user = $this->getUser();
            $account = $this->accountService->getById($accountId);
             if(!$account){
                throw new RessourceNotFoundException("Ce compte n'existe pas dans la base de donnee");
            }
            $checks = $this->serializer->serialize($this->chequeService->allByActorAndAccount($user, $account), 'json');
            return  new JsonResponse([
                'message' => 'Checks found',
                'data' => json_decode($checks),
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


     #[Route('/all/by_user',name: 'app_cheque_all_by_user', methods: ['GET'])]
    public function allByUser():JsonResponse
    {
        try {
            $user = $this->getUser();
            $checks = $this->serializer->serialize($this->chequeService->allByUser($user), 'json');
            return  new JsonResponse([
                'message' => 'Checks found',
                'data' => json_decode($checks),
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
    
}
