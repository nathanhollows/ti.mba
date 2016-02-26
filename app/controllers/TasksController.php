<?php

namespace App\Controllers;


class TasksController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{
		$this->tag->prependTitle('Tasks');
		
		// Fetch today's current tasks belonging to the logged in user

		// Send the Tasks form and Tasks list to the view
		$this->view->tasks = $tasks;

	}
}