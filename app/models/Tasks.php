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
     public $followUp;

	/**
     *
     * @var string
     */
	public $completed;

	public function initialize()
	{
		$this->hasOne('user', 'App\Models\Users', 'id', array('alias' => 'User'));
	}

     public static function getToday($count = null)
     {
          $auth = new Auth;
          $tasks = Tasks::find(array(
               'conditions'   => 'user = ?1 AND completed IS NULL AND followUp IS NULL OR followUp <= ?2 AND completed IS NULL',
               'bind'         => array(
                    1         => $auth->getId(),
                    2         => date('Y-m-d')
               )
          ));

          if (isset($count)) {
               return count($tasks);
          } else {
               return $tasks;
          }
     }

     public static function getFuture()
     {
          $auth = new Auth;
          $tasks = Tasks::Find(array(
               'conditions'   => 'user = ?1 and completed IS NULL and followUp > ?2',
               'bind'         => array(
                    1         => $auth->getId(),
                    2         => date('Y-m-d')
               )
          ));

          return $tasks;
     }
}