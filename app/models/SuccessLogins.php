<?php

namespace App\Models;

class SuccessLogins extends \Phalcon\Mvc\Model
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
    public $usersId;

    /**
     *
     * @var string
     */
    public $ipAddress;

    /**
     *
     * @var string
     */
    public $userAgent; 

    /**
     *
     * @var string
     */
    public $timestamp;

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return SuccessLogins
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
