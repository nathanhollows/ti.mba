<?php

namespace App\Controllers;

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
        $freight = new Freight;
        $this->view->pbt = $freight->downloadPBT();
        $this->view->pbt = $freight->importPBT();
    }
}