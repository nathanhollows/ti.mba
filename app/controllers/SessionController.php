<?php

namespace App\Controllers;

use App\Forms\SignUpForm;

class RegisterController extends ControllerBase
{
	public function signupAction()
	{
		$form = new SignUpForm();

		// ..

		$this->view->form = $form;
	}
}