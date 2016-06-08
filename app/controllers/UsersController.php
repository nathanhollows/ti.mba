<?php

namespace App\Controllers;

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
