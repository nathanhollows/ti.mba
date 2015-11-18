<?php

namespace App\Controllers;

use Phalcon\Tag;

class AboutController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('public');
        parent::initialize();
	}

    public function indexAction()
    {
    	$this->tag->prependTitle('About');
    }
}
