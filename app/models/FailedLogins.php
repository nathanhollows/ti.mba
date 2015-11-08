<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class FailedLogins extends Model
{

	public $id;

	public $usersId;

	public $ipAddress;

	public $attempted;

	public function initialize()
	{
		$this->belongsTo('usersId', __NAMESPACE__ . '\Users', 'id', array(
			'alias'	=> 'user'
		));
	}
}