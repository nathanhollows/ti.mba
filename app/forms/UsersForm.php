<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\TextArea,
	Phalcon\Forms\Element\Date,
	Phalcon\Forms\Element\Email,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Hidden,
	Phalcon\Forms\Element\Password,
	Phalcon\Forms\Element\Submit;

use App\Auth\Auth,
	App\Models\Users;

class UsersForm extends Form
{
	// Initialize the Follow Up form
	public function initialize($entity = null, $option = null)
	{

		$auth = new Auth;

		$id = new Hidden('id', $auth->getId());
		$this->add($id);

		$name = new Text('name');
		$name->setAttributes(array(
			"class"		=> "form-control",
			"required"	=> "true",
		));
		$name->setLabel("Name");
		$this->add($name);

		$position = new Text('position');
		$position->setAttributes(array(
			"class"		=> "form-control",
		));
		$position->setLabel("Position");
		$this->add($position);

		$phone = new Text('directDial');
		$phone->setAttributes(array(
			"class"		=> "form-control",
		));
		$phone->setLabel("Phone");
		$this->add($phone);

		$email = new Email('email');
		$email->setAttributes(array(
			"class"		=> "form-control",
			"required"	=> "true",
		));
		$email->setLabel("Email");
		$this->add($email);

		$currentPass = new Password('currentPass');
		$currentPass->setAttributes(array(
			"class"		=> "form-control",
			"required"	=> "true",
		));
		$currentPass->setLabel("Old Password");
		$this->add($currentPass);

		$newPassword = new Password('newpw');
		$newPassword->setAttributes(array(
			"class"		=> "form-control",
		));
		$newPassword->setLabel("New Password");
		$this->add($newPassword);

		$validatePassword = new Password('newpw2');
		$validatePassword->setAttributes(array(
			"class"		=> "form-control",
		));
		$validatePassword->setLabel("New Password");
		$this->add($validatePassword);


	}

}