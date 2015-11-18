<?php

namespace App\Controllers;

use Phalcon\Tag;

class ContactController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('public');
        parent::initialize();
	}

    public function indexAction()
    {
    	$this->tag->prependTitle('Contact Us');
		echo '[' . __METHOD__ . ']';
    }
}
