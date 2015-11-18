<?php

namespace App\forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Email,
	Phalcon\Forms\Element\Submit,
	Phalcon\Forms\Element\Text,
	Phalcon\Validation\Validator\PresenceOf,
	Phalcon\Validation\Validator\Email as EmailValidate;

class CustomersForm extends Form
{

	public function initialize()
	{
		
	}

}