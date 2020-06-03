<?php

namespace App\Models;

class RememberTokens extends \Phalcon\Mvc\Model
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
    public $token;

    /**
     *
     * @var string
     */
    public $userAgent;

    /**
     *
     * @var integer
     */
    public $createdAt;

    public function beforeValidationOnCreate()
    {
        // Timestamp the confrimation
        $this->createdAt = time();
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RememberTokens
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
}
