<?php

namespace App\Controllers;

use App\Freight\Freight;
use App\Models\ContactRecord;

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
        $config = include __DIR__ . "/../config/config.php";

        $tasks = new ContactRecord;

        $this->view->tasks = $tasks->getTasks();

        if ($config->pbt->enable) {
            $freight = new Freight;
            $this->view->pbt = $freight->downloadPBT();
            $this->view->pbt = $freight->importPBT();
        }

    }
}