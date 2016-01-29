<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Submit,
	App\Models\Users,
	App\Auth\Auth;

class TasksForm extends Form
{
	public function initialize()
	{
		$auth = new Auth;

		$blurb = new Text("description");
		$blurb->setLabel("Blurb");
		$this->add($blurb);

		$user = new Select('user', Users::find(), array('using' => array('id', 'name')));
		$user->setDefault($auth->getId());
		$user->setLabel("User");
		$this->add($user);

		$submit = new Submit("Submit");
		$this->add($submit);
	}
}