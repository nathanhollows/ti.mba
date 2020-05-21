<?php

namespace App\Models;

class Permissions extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var integer
     */
    public $profilesId;

    /**
     *
     * @var string
     */
    public $resource;

    /**
     *
     * @var string
     */
    public $action;

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Permissions
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
