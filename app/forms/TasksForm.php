<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Submit,
	Phalcon\Forms\Element\TextArea,
	App\Models\Users,
	App\Auth\Auth;

class TasksForm extends Form
{
	public function initialize()
	{
		$auth = new Auth;

		$blurb = new TextArea('description', array(
			'required'	=> 'true',
			'class'		=> 'form-control',
			'placeholder'	=> 'Milk, eggs, salami, muesli, chocolate..',
			'autofocus'	=> 'true'));
		$blurb->setLabel("Description");
		$this->add($blurb);

		$user = new Select('user', Users::find(), array(
			'using' 	=> array('id', 'name'),
			'required'	=> 'true',
			'class'		=> 'form-control'));
		$user->setDefault($auth->getId());
		$user->setLabel("User");
		$this->add($user);
	}
}