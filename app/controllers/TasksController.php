<?php

namespace App\Controllers;

use App\Models\ContactRecord;

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
		$data = new ContactRecord;
		$tasks = $data->getTasks();
		$futureTasks = $data->getFutureTasks();
        $this->view->parser = new \cebe\markdown\Markdown();

		// Send the Tasks form and Tasks list to the view
		$this->view->tasks = $tasks;
		$this->view->upcoming = $futureTasks;

	}
}