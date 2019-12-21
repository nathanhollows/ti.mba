<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\Uniqueness;

class Users extends Model
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
    public $email;

    /**
     *
     * @var string
     */
    public $password;

    /**
     *
     * @var int
     */
    public $mustChangePassword;

    /**
     *
     * @var integer
     */
    public $profilesId;

    /**
     *
     * @var string
     */
    public $banned;

    /**
     *
     * @var int
     */
    public $suspended;

    /**
     *
     * @var int
     */
    public $active;

    /**
     *
     * @var int
     */
    public $dev;

    /**
     *
     * @var int
     */
    public $useUCA;

    /**
     * Validations and business logic
     *
     * @return boolean
     */
    public function validation()
    {
        $validation = new \Phalcon\Validation();
        $validation->add('email', new Email(array(
         'message' => 'The e-mail is not valid'
         )));

        $messages = $validation->validate($_POST);
        if (count($messages)) {
            foreach ($messages as $message) {
                echo $message, '<br>';
            }
        }
    }

    public function initialize()
    {
        $this->hasMany('id', 'App\Models\Customers', 'manager', array('alias' => 'customers', 'params' => array('order' => 'rank ASC')));
        $this->hasMany('id', 'App\Models\Quotes', 'user', array('alias' => 'quotes', 'params' => array('conditions' => "status <> 4", "order" => 'quoteId DESC')));
        $this->hasMany('id', 'App\Models\Quotes', 'user', array('alias' => 'allquotes', 'params' => array("order" => 'quoteId DESC')));
        $this->hasMany('id', 'App\Models\ContactRecord', 'user', array('alias' => 'history'));
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Users
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'users';
    }

    /**
     * Activates the selected user
     *
     * @return boolean
     */
    public static function activate()
    {
        $this->active = 1;
    }

    public static function listUsers()
    {
        $results = parent::find(array(
            "columns"   => "id,name",
        ));
        return $results;
    }

    public static function getActive()
    {
        $results = parent::find(array(
            "conditions"   => "active = 1 AND suspended = 0 AND banned = 0 AND id != 10",
            "order"       => "FIELD(name, 'Fax'), name ASC",
        ));
        return $results;
    }

}
