<?php

use Phalcon\Tag;

class LoginController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Login');
        parent::initialize();
	}

    public function indexAction()
    {

    }
}
