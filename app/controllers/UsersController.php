<?php

namespace App\Controllers;

use App\Models\Users;

class UsersController extends ControllerBase
{

	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{
		$this->tag->prependTitle('Users');
		$this->view->users = Users::find();
	}

	public function editAction()
	{
		$this->tag->prependTitle('Users');
	}

	public function newAction()
	{
		$this->tag->prependTitle('Users');
	}

	public function createAction()
	{
		$this->view->disable();
	}

	public function updateAction()
	{
		$this->view->disable();
	}
}
