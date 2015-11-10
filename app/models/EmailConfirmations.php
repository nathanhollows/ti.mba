<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class EmailConfirmations extends Model
{
	public $id;

	public $usersId;

	public $code;

	public $createdAt;

	public $modifiedAt;

	public $confirmed;

	// Before creating the user assign a password

	public function beforeValidationOnCreate()
	{
		// Timestamp the confirmations
		$this->createdAt = time();

		// Generate a random confirmation code
		$this->code = preg_replace('/[^a-zA-Z0-9]/', '', base64_encode(openssl_random_pseudo_bytes(24)));

		// Set status to non-confirmed
		$this->confirmed = 'N';
	}

	// Sets the timestamp before update the confirmation

	public function beforeValidationOnUpdate()
	{
		// Timestamp the confirmation
		$this->modifiedAt = time();
	}

	public function afterCreate()
	{
		$this->getDI()
			->getMail()
			->send(array(
				$this->user->email => $this->user->name
			), "Please confirm your email", 'confirmation', array(
				'confirmUrl' => '/confirm/' . $this->code . '/' . $this->user->email
			));
	}

	public function initialize()
	{
		$this->belongsTo('usersId', __NAMESPACE__ . '\Users', 'id', array(
			'alias'	=> 'user'
		));
	}

}