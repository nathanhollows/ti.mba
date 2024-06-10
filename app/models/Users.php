<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation\Validator\Email;

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
    public $position;

    /**
     *
     * @var string
     */
    public $directDial;

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
    public $developer;

    /**
     *
     * @var int
     */
    public $administrator;

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
        $this->hasMany('id', 'App\Models\SalesAreas', 'agent', array('alias' => 'regions', 'params' => array('order' => 'ordering')));
    }

    /**
     * Activates the selected user
     *
     * @return boolean
     */
    public function activate()
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
            "conditions"   => "active = 1 AND suspended = 0 AND developer = 0",
            "order"       => "FIELD(name, 'Bunnings Stock', 'Fax'), name ASC",
        ));
        return $results;
    }

    public static function getUsersWithRegions()
    {
        $results = parent::find(array(
            "conditions"   => "active = 1 AND suspended = 0 AND developer = 0",
            "order"       => "name ASC",
            "with"        => "regions",
        ));
        return $results;
    }
}
