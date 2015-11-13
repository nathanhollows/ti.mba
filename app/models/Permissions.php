<?php

namespace App\Models;

use Phalcon\Mvc\Model;

// Stores the permissions by profile

class Permissions extends Model
{
	public $id;

	public $profilesId;

	public $resource;

	public $action;

	public function initialize()
	{

		$this->belongsTo('profilesId', __NAMESPACE__ . '\Profiles', 'id', array(
			'alias'	=> 'profile'
		));
	}


}