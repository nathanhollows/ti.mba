<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\TextArea,
	Phalcon\Forms\Element\Date,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Hidden,
	Phalcon\Forms\Element\Submit;

use App\Auth\Auth;

use App\Models\Customers,
	App\Models\Contacts,
	App\Models\Users;

class ReminderForm extends Form
{
	// Initialize the Follow Up form
	public function initialize($entity = null, $option = null)
	{
		$uri = new Hidden('uri');
		$this->add($uri);

		$details = new TextArea("notes");
		$details->setAttributes(array(
			'class'		=> 'form-control markdown-edit',
			'data-provide'=>'markdown-editable',
			'autofocus'	=> 'true',
			'data-iconlibrary'=>'fa',
			));
		$details->setLabel("Details");
		$this->add($details);

		$date = new Date("followUpDate");
		$date->setAttributes(array(
			'value'		=> date('Y-m-d'),
			'required'	=> 'true',
			'class'		=> 'form-control'
			));
		$date->setLabel("Date");
		$this->add($date);
		
		$auth = new Auth();

		$rep = new Select(
			"followUpUser",
			Users::find(),
			array(
				'using'	=> array(
					'id',
					'name'
				),
			"required"	=> "true",
			"class"		=> "form-control",
			)
		);
		$rep->setLabel("Sales Rep");
		$rep->setDefault($auth->getId());
		$this->add($rep);

		$submit = new Submit("submit");
		$submit->setAttributes(array(
			'class'	=> 'btn btn-primary'
		));
		$this->add($submit);
	}
}