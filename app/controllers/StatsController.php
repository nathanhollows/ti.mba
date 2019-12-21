<?php

namespace App\Controllers;

use Phalcon\Tag;

class StatsController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('private');
        parent::initialize();
	}

    public function indexAction()
    {
    	$this->tag->prependTitle('About');
    }
}
