<?php

namespace App\Models;

class ContactRecord extends \Phalcon\Mvc\Model
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
    }
}