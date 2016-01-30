<?php

namespace App\Controllers;

use App\Models\Tasks;

class DashboardController extends ControllerBase
{
	public function initialize()
	{
        if ($this->session->has('auth-identity')) {
            $this->view->setTemplateBefore('private');
        }
        $this->tag->prependTitle('Dashboard');
        parent::initialize();
	}

    public function indexAction()
    {
        $myTasks = Tasks::getCount();
        $this->view->myTasks = $myTasks;
    }
}