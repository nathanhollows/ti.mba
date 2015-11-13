<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Profiles extends Model
{
	public $id;

	public $name;

	public function initialize()
	{
		$this->hasMany('id', __NAMESPACE__ . '\Users', 'profilesId', array(
			'alias'		=> 'users',
			'foreignKey'	=> array(
				'message'	=> 'Profile cannot be deleted becase it\'s used on Users'
			)
		));

		$this->hasMany('id', __NAMESPACE__ . '\Permissions', 'profilesId', array(
			'alias'	=> 'permissions'
		));
	}
}