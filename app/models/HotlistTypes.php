<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class HotlistTypes extends Model
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
    public $name;

    /**
     *
     * @var string
     */
    public $description;
}
