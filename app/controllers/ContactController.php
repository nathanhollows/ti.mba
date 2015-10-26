<?php

use Phalcon\Tag;

class ContactController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Contact');
        parent::initialize();
	}

    public function indexAction()
    {

    }
}
