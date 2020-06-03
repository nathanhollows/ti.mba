<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class QuoteCodes extends Model
{
    public $code;

    public $description;

    public $grade;

    public $treatment;

    public $dryness;
}
