<?php

use Phalcon\Tag;

class AuthController extends ControllerBase
{

	protected function initialize()
	{
        parent::initialize();
	}

    public function loginAction()
    {
        $this->tag->setTitle('Login');

    }

    public function signupAction()
    {
        $this->tag->setTitle('Signup');

    }
}
