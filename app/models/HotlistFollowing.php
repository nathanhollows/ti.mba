<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class HotlistFollowing extends Model
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
    public $user;

    /**
     *
     * @var string
     */
    public $timestamp;

    public function initialize()
    {
        $this->hasOne('user', 'App\Models\Users', 'id', array('alias' => 'details'));
    }

}
