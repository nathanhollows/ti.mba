<?php

namespace App\Models;

class ContactType extends \Phalcon\Mvc\Model
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

    public function initialize()
    {
        $this->hasMany('id', 'App\Models\ContactRecord', 'contactType', array('alias' => 'ContactRecord'));
    }
}
