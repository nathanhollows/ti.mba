<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Email;
use Phalcon\Validation\Validator\PresenceOf;

class ContactsForm extends Form
{
	/**
	 * Initialize the products form
	 */

	public function initialize()
	{
		$name = new Text("name");
		$name->setLabel("Name");
		$name->setFilters(array('striptags', 'string'));
		$name->addValidators(array(
			new PresenceOf(array(
				'message'	=> 'Name is required'
			))
		));
		$name->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Name',
			'required'		=> 'true'
		));
		$this->add($name);

		$position = new Text("position");
		$position->setLabel("Position");
		$position->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Position',
		));
		$this->add($position);

		$email = new Email("email");
		$email->setLabel("Email Address");
		$email->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'email@example.com',
		));
		$this->add($email);

		$phone = new Text("directDial");
		$phone->setLabel("Phone");
		$phone->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Direct Dial',
		));
		$this->add($phone);	
	}
}