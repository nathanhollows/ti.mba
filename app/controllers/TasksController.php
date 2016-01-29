<?php

namespace App\Controllers;

use App\Models\Tasks;
use App\Auth\Auth;
use App\Forms\TasksForm;

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
		
		// Fetch all current tasks belonging to the logged in user
		$auth = new Auth;
		$tasks = Tasks::find(array(
			'conditions'	=> 'user = ?1 AND completed IS NULL',
			'bind'			=> array(
				1 =>  $auth->getId(),
			)
		));

		// Send the Tasks form and Tasks list to the view
		$this->view->tasks = $tasks;
		$this->view->taskForm = new TasksForm;

	}

	public function completeAction($id)
	{
		$task = Tasks::findFirst("id = '$id'");
		$task->completed = date("Y-m-d H:i:s");
		$task->save();
		$this->response->redirect('tasks/');
	}

	public function addAction()
	{
		if (!$this->request->isPost()) {
			return $this->dispatcher->forward(array(
				"controller"	=> "tasks",
				"action"		=> "index"
			));
		}

		$task = new Tasks();

		// Store and check for errors
		$success = $task->save($this->request->getPost(), array('description', 'user'));

		if ($success) {
			$this->response->redirect('/tasks/');	
			$this->view->disable;
		} else {
			$this->flash->error("Sorry, the task could not be saved");
			foreach ($task->getMessages() as $message) {
				echo ($message->getMessage() . "<br/>");
			}
		}
	}
}