<?php

namespace App\Controllers;

use App\Auth\Auth;
use App\Models\ContactRecord;

class TasksController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction($userId = null)
	{
		$auth = new Auth;
		$user = $auth->getId();

		if (isset($userId)) {
			$user = $userId;
		}

		$this->tag->prependTitle('Tasks');
		
        $this->view->parser = new \cebe\markdown\Markdown();

		// Fetch today's current tasks belonging to the logged in user
		$data = new ContactRecord;

		$this->view->overdue	= $data->getOverdue($user);
		$this->view->today		= $data->getToday($user);
		$this->view->coming 	= $data->getComing($user);

	}

}