<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class QuoteStatus extends Model
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
    public $statusName;

    /**
     *
     * @var string
     */
    public $style;
}
