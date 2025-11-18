<?php 

namespace App\Services\Helpers;

class HelperFonction{
    static function generateDigitNumber(): string{
        return random_int(100000, 999999);
    }
}