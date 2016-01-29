<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Auth\Auth;

class Tasks extends Model
{
	/**
     *
     * @var integer
     */
	public $id;

	/**
     *
     * @var integer
     */
	public $user;

	/**
     *
     * @var string
     */
	public $description;

	/**
     *
     * @var string
     */
	public $created;

	/**
     *
     * @var string
     */
	public $completed;

	public function initialize()
	{
		$this->hasOne('user', 'App\Models\Users', 'id', array('alias' => 'User'));
	}

     public static function getCount()
     {
          $auth = new Auth;
          $tasks = Tasks::find(array(
               'conditions'   => 'user = ?1 AND completed IS NULL',
               'bind'              => array(
                    1 =>  $auth->getId(),
               )
          ));
          return count($tasks);

     }
}