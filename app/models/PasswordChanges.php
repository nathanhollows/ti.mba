<?php

namespace App\Models;

use Phalcon\Mvc\Model;

// Register when a user changes his/her password

class PasswordChanges extends Model
{
	public $id;

	public $userId;

	public $ipAddress;

	public $userAgent;

	public $createdAt;

	public function beforeValidatioOnCreate()
	{
		// Timestamp the confirmation
		$this->createdAt = time();
	}

	public function initiliaze()
	{
		$this->belongsTo('usersId', __NAMESPACE__ . '\Users', 'id', array(
			'alias'	=> 'user'
		));
	}
}