<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Plugins\Auth\Auth;

class ContactRecord extends Model
{
	/**
     *
     * @var integer
     */
	public $id;

    /**
     *
     * @var date
     */
	public $date;

    /**
     *
     * @var string
     */
	public $customerCode;

    /**
     *
     * @var integer
     */
	public $user;

	/**
     *
     * @var integer
     */
	public $contactType;

	/**
     *
     * @var integer
     */
	public $status;

    /**
     *
     * @var string
     */
	public $contactReference;

    /**
     *
     * @var string
     */
	public $details;

	/**
     *
     * @var integer
     */
	public $followUpUser;

    /**
     *
     * @var date
     */
	public $followUpDate;

    /**
     *
     * @var string
     */
	public $followUpNotes;

    /**
     *
     * @var string
     */
	public $infoSent;

	/**
     *
     * @var integer
     */
	public $attachments;

	/**
     *
     * @var integer
     */
	public $completed;

	public function initialize()
	{
        $this->hasOne('user', 'App\Models\Users', 'id', array('alias'  => 'staff'));
		$this->hasOne('contact', 'App\Models\Contacts', 'id', array('alias'  => 'person'));
        $this->hasOne('contactType', 'App\Models\ContactType', 'id', array('alias'  => 'type'));
		$this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias'  => 'company'));
		$this->hasOne('job', 'App\Models\Quotes', 'quoteId', array('alias'  => 'quote'));
	}

    public function beforeCreate()
    {
        $this->date = date('Y-m-d H:i:s');
    }

    public static function getOutstanding($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed is NULL AND followUpDate IS NOT NULL",
            "bind"  => array(1 => $user),
            "order" => "followUpDate ASC",
        ));
    }

    public function getToday($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed is NULL AND followUpDate = DATE(NOW())",
            "bind"  => array(1 => $user),
            "order" => "customerCode ASC",
        ));
    }

    public function getOverdue($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed is NULL AND followUpDate < DATE(NOW())",
            "bind"  => array(1 => $user),
            "order" => "followUpDate ASC",
        ));
    }

    public static function getOverdueTotal()
    {
        return parent::count(array(
            "conditions" => "completed is NULL AND followUpDate <= DATE(NOW())"
        ));
    }

    public static function getFutureByCustomer($customerCode)
    {
        return parent::find(array(
            "conditions" => "customerCode = ?1 AND completed IS NULL",
            "bind"  => array(1 => $customerCode),
            "order" => 'followUpDate ASC'
        ));
    }

    public function getComing($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed is NULL AND followUpDate > DATE(NOW())",
            "bind"  => array(1 => $user),
            "order" => "customerCode ASC",
        ));
    }

    public function complete()
    {
        $this->completed = 1;
        $success = $this->save();
        if ($success) {
            return true;
        } else {
            return false;
        }
    }

    public function isOverdue()
    {
        if ($this->followUpDate < date("Y-m-d") and is_null($this->completed)) {
            return true;
        } else {
            return false;
        }
    }

}
