<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Hidden ;
use Phalcon\Validation\Validator\PresenceOf;

use App\Models\Contacts;
use App\Models\Customers;
use App\Models\ContactRoles;

class ContactsForm extends Form
{
	/**
	 * Initialize the contact form
	 */

	public function initialize($entity = null, $option = null)
	{
		$id = new Hidden("id");
		$this->add($id);

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

		$position = new Select(
			'position',
			ContactRoles::find(array("order" => "rank ASC")),
			array(
				'using'	=> array('id', 'name'),
				'required'	=> 'true',
				'class'	=> 'form-control'
			)
		);
		$position->setLabel("Position");
		$this->add($position);

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