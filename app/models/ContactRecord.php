<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Auth\Auth;

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
	}

    public function beforeCreate()
    {
        $this->date = date('Y-m-d H:i:s');
        $auth = new Auth;
        $this->user = $auth->getId();
    }

    public function getToday($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed = 0 AND followUpDate = DATE(NOW())",
            "bind"  => array(1 => $user)
        ));
    }

    public function getOverdue($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed = 0 AND followUpDate < DATE(NOW())",
            "bind"  => array(1 => $user)
        ));
    }

    public function getComing($user = null)
    {
        if (!$user) {
            $auth = new Auth;
            $user = $auth->getId();
        }
        return parent::find(array(
            "conditions" => "user = ?1 AND completed = 0 AND followUpDate > DATE(NOW())",
            "bind"  => array(1 => $user)
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

}