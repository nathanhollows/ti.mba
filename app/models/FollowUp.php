<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class FollowUp extends Model
{
	/**
     *
     * @var integer
     */
    public $id;

	/**
     *
     * @var string
     */
    public $controller;

	/**
     *
     * @var string
     */
    public $action;

	/**
     *
     * @var string
     */
    public $params;

	/**
     *
     * @var integer
     */
    public $user;

	/**
     *
     * @var string
     */
    public $date;

	/**
     *
     * @var string
     */
    public $notes;

	/**
     *
     * @var string
     */
    public $followUpDate;

	/**
     *
     * @var string
     */
    public $followUpUser;

	/**
     *
     * @var string
     */
    public $followUpNotes;

	/**
     *
     * @var string
     */
    public $completed;

    public function initialize()
    {
    	$this->hasOne('user', 'App\Models\User', 'id');
    	$this->hasOne('followUpUser', 'App\Models\Users', 'id', array('alias' => 'chaseUser'));
    }

    public function getToday($user)
    {
        return parent::find(array(
            "conditions" => "followUpUser = ?1 AND completed is Null AND followUpDate = DATE(NOW())",
            "bind"  => array(1 => $user)
        ));
    }

    public function getOverdue($user)
    {
        return parent::find(array(
            "conditions" => "followUpUser = ?1 AND completed is Null AND followUpDate < DATE(NOW())",
            "bind"  => array(1 => $user)
        ));
    }

    public function getComing($user)
    {
        return parent::find(array(
            "conditions" => "followUpUser = ?1 AND completed is Null AND followUpDate > DATE(NOW())",
            "bind"  => array(1 => $user)
        ));
    }

    public function complete()
    {
        $this->completed = date('Y-m-d H:i:s');
        $success = $this->save();
        if ($success) {
            return true;
        } else {
            return false;
        }
     }

}