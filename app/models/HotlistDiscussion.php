<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class HotlistDiscussion extends Model
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
    public $timestamp;

    /**
     *
     * @var int
     */
    public $user;

    /**
     *
     * @var string
     */
    public $comment;

    public function initialize()
    {
        $this->hasOne('user', 'App\Models\Users', 'id');
    }
}
