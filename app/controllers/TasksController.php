<?php

namespace App\Controllers;

use App\Models\FollowUp;

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
		$tasks = FollowUp::find(array(
			"completed = ''",
			));
		$this->view->tasks = $tasks;
	}

	public function completeAction($id)
	{
		$task = FollowUp::findFirst("id = '$id'");
		$task->completed = date("Y-m-d");
		$task->save();
		$this->response->redirect('tasks/');
	}
}