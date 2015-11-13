<?php
namespace App\Models;

use Phalcon\Mvc\Model;

// Stores the remember me tokens

class RememberTokens extends Model
{
	public $id;

	public $usersId;

	public $token;

	public $userAgent;

	public $createdAt;

	public function beforeValidationOnCreate()
	{
		// Timestamp the confirmation
		$this->createdAt = time();
	}

	public function initialize()
	{
		$this->belongsTo('usersId', __NAMESPACE__ . '\Users', 'id', array(
			'alias'	=> 'user'
		));
	}
}