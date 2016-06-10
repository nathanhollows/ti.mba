<?php

namespace App\Forms\Quotes;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Submit;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use App\Auth\Auth;
use App\Models\Users;
use App\Models\Customers;
use App\Models\Contacts;
use App\Models\GenericStatus;

class QuotesForm extends Form
{

	/**
	 * Initiliaze the quotes form
	 */

	public function initialize($entity = null, $option = null)
	{
		$validation = new Validation();

		$id = new Hidden('quoteId');
		$this->add($id);

		$customerCode = new Select(
			'customerCode',
			Customers::find(),
			array(
				'using' => array('customerCode', 'customerName'),
				'required'	=> 'true',
				'useEmpty'	=> true,
				'class' => 'form-control selectpicker',
				'data-live-search' => 'true',
			)
		);
		$customerCode->setLabel("Customer");
		$this->add($customerCode);

		if (isset($option["customerCode"])) {
			$customerCode = $option["customerCode"];
			$contactRestrict = array("customerCode = '$customerCode'");
		} else {
			$contactRestrict = array("order"	=> "name");
		}

		$contact = new Select(
			'contact',
			Contacts::find($contactRestrict),
			array(
				'using'	=> array('id', 'name'),
				'required'	=> 'true',
				'useEmpty'	=> true,
				'class'	=> 'form-control selectpicker',
				'data-live-search' => 'true',
				)
		);
		$contact->setLabel("Contact");
		$this->add($contact);

		$reference = new Text("reference");
		$reference->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
			));
		$reference->setLabel("Our Reference");
		$this->add($reference);

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
			'class'		=> 'form-control',
			'placeholder' => 'This will be visible on the quote'
		));
		$notes->setLabel("Notes");
		$this->add($notes);

		$moreNotes = new TextArea("moreNotes");
		$moreNotes->setAttributes(array(
			'class'		=> 'form-control',
			'placeholder' => 'Private notes. These will not be visible on the customers version'
		));
		$moreNotes->setLabel("Private Notes");
		$this->add($moreNotes);

		$auth = new Auth;
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
		$salesAgent->setDefault($auth->getId());
		$this->add($salesAgent);

		$status = new Select(
			"status",
			GenericStatus::find(),
			array(
				'using'	=> array(
					'id',
					'name'
					),
				'class'	=> 'form-control'
				)
			);
		$status->setLabel("Status");	
		$status->setDefault('1');
		$this->add($status);

		$submit = new Submit("Submit");
		$submit->setAttributes(array(
			'class'	=> 'btn btn-primary',
			));
		$this->add($submit);
	}
}