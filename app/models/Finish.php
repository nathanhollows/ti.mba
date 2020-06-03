<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Finish extends Model
{
    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $shortCode;

    /**
     *
     * @var string
     */
    public $name;
}
