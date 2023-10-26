<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Grade extends Model
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

    /**
     *
     * @var integer
     */
    public $active;
}
