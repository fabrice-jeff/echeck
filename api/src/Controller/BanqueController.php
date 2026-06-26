<?php

namespace App\Controller;

use App\Exception\RessourceNotFoundException;
use App\Request\Banque\BanqueRequest;
use App\Services\Banque\IBanqueService;
use App\Utils\Constants\AppValuesConstants;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\Exception\ExceptionInterface;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

#[Route('/api/banque')]
class BanqueController extends AbstractController
{
    public function __construct(
        private readonly IBanqueService $banqueService,
        private readonly SerializerInterface $serializer,
        private readonly ValidatorInterface $validator,
    )
    {
    }

    #[Route('/add',name: 'app_banque_add', methods: ['POST'])]
    public function add(Request $request): JsonResponse
    {
        try {
            $json = $request->getContent();
            $banqueRequest = $this->serializer->deserialize($json, BanqueRequest::class, 'json');
            $validation = AppValuesConstants::validation($banqueRequest, $this->validator);
            if($validation === true)
            {
                $this->banqueService->add($banqueRequest);
                return new JsonResponse([
                    'message' => 'Banque add Success',
                    'data' => null
                ]);
            }
            else{
                return new JsonResponse(['errors' => $validation], 400);
            }
        }
        catch (ExceptionInterface  $e) {
            return new JsonResponse([
                'message' => $e->getCode(),
            ]);
        }
    }

    #[Route('/{id}/update', name: 'app_banque_update', methods: ['PUT'])]
    public function update (Request $request, $id): JsonResponse
    {
        try {
            $json = $request->getContent();
            $banqueRequest = $this->serializer->deserialize($json, BanqueRequest::class, 'json');
            $validation = AppValuesConstants::validation($banqueRequest, $this->validator);
            if ($validation === true)
            {
                $this->banqueService->update($banqueRequest, $id);
                return new JsonResponse([
                    'message' => 'Banque update Success',
                    'data' => null
                ]);
            }
            else
            {
                return new JsonResponse(['errors' => $validation], 400);
            }
        }
        catch (ExceptionInterface $e) {
            return new JsonResponse([
                'message' => $e->getMessage(),
            ]);
        }
    }


    #[Route('/all', name: 'app_banque_all', methods: ['GET'])]
    public function all():JsonResponse
    {
        try {
            $banque = $this->serializer->serialize($this->banqueService->all(), 'json');
            return new JsonResponse(
                [
                    'message' => 'List all banques',
                    'data' => json_decode($banque),
                    'code' => Response::HTTP_OK,
                ]
            );
        }
        catch (ExceptionInterface $e) {
            return new JsonResponse([
                'message' => $e->getMessage(),
            ]);
        }
    }
    #[Route('/{id}/delete', name: 'app_banque_delete', methods: ['DELETE'])]
    public function delete(int $id): JsonResponse
    {
        try {
            $this->banqueService->delete($id);
            return new JsonResponse([
                'message' => 'Banque delete Success',
                'data' => null
            ]);
        }
        catch (ExceptionInterface $e) {
            return new JsonResponse([
                'message' => $e->getMessage(),
            ]);
        }
    }



}
