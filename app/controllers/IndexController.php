<?php

namespace App\Controllers;

use Phalcon\Tag;

class IndexController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('public');
        parent::initialize();
	}

    public function indexAction()
    {
    	$this->view->disable();
    	$this->response->redirect('dashboard');
    }
}
