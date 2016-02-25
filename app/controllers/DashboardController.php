<?php

namespace App\Controllers;

use App\Models\Tasks;
use App\Freight\Freight;

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
        $myTasks = Tasks::getToday('count');
        $this->view->myTasks = $myTasks;
        $freight = new Freight;
        $this->view->pbt = $freight->downloadPBT();
        $this->view->pbt = $freight->importPBT();
    }
}