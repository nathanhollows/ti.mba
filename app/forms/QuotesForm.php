<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Submit;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

use App\Models\Users;

class QuotesForm extends Form
{

	/**
	 * Initiliaze the quotes form
	 */

	public function initialize()
	{
		$validation = new Validation();

		$customerCode = new Text("customerCode");
		$customerCode->setLabel("Customer");
		$customerCode->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
		));
		$this->add($customerCode);

		$contact = new Text("contact");
		$contact->setAttributes(array(
			'class'		=> 'form-control'
		));
		$contact->setLabel("Contact");
		$this->add($contact);

		$customerRef = new Text("customerRef");
		$customerRef->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
		));
		$customerRef->setLabel("Customer Reference");
		$this->add($customerRef);

		$date = new Date("date");
		$date->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
		));
		$date->setLabel("Date");
		$date->setDefault(date('Y-m-d'));
		$this->add($date);

		$notes = new TextArea("notes");
		$notes->setAttributes(array(
			'class'		=> 'form-control'
		));
		$notes->setLabel("Notes");
		$this->add($notes);

		$salesAgent = new Select(
			"user",
			Users::find(),
			array(
				'using'	=> array(
					'id',
					'name'
				),
				'class'	=> 'form-control'
			)
		);
		$salesAgent->setLabel("Sales Agent");	
		$salesAgent->setDefault('3');
		$this->add($salesAgent);

		$submit = new Submit("submit");
		$submit->setAttributes(array(
			'class'	=> 'btn btn-primary'
		));
		$this->add($submit);
	}
}