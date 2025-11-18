<?php

namespace App\Services\Banque;

use App\Entity\Banque;
use App\Request\Banque\BanqueRequest;

interface IBanqueService
{
    public function getById(int $id):?Banque;
    public function getByName(string $name):?Banque;
    public function all():array;
    public function add(BanqueRequest $request):void;
    public function update(BanqueRequest $request, int $id):void;
    public function delete(int $id):void;


}
