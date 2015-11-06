<?php

namespace App\Controllers;

use App\Forms\SignUpForm;

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

        $form = new SignUpForm();

    }

    public function registerAction()
    {
        $user = new Users();

        // Store and check for errors
        $success = $user->save($this->request->getPost(), array('name', 'email'));

        if ($success) {
            echo "Thanks for registering!";
        } else {
            echo "Sorry, the following problems were generated.";
            foreach ($user->getMessages() as $message) {
                echo $message->getMessage(), "<br/>";
            }
        }

        $this->view->disable();
    }
}
