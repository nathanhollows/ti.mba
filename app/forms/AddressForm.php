<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Hidden,
	Phalcon\Forms\Element\Text;

use App\Models\AddressTypes,
	App\Models\Customers;

class AddressForm extends Form
{
	/**
	 * Initialize the address form
	 */

	public function initialize($entity = null, $option = null)
	{
		$id = new Hidden('id');
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

		$type = new Select(
			'typeCode',
			AddressTypes::find(),
			array(
				'using' => array('typeCode', 'typeDescription'),
				'required'	=> 'true',
				'class' => 'form-control'
			)
		);
		$type->setLabel("Type");
		$this->add($type);

		$line1 = new Text('line1');
		$line1->setLabel('Line 1');
		$line1->setAttributes(array(
			"class"	=> "form-control",
		));
		$this->add($line1);

		$line2 = new Text('line2');
		$line2->setLabel('Line 2');
		$line2->setAttributes(array(
			"class"	=> "form-control",
		));
		$this->add($line2);

		$line3 = new Text('line3');
		$line3->setLabel('Line 3');
		$line3->setAttributes(array(
			"class"	=> "form-control",
		));
		$this->add($line3);

		$zip = new Text('zipCode');
		$zip->setLabel('Zip Code');
		$zip->setAttributes(array(
			"class"	=> "form-control",
		));
		$this->add($zip);

		$city = new Text('city');
		$city->setLabel('City / Town');
		$city->setAttributes(array(
			"class"	=> "form-control",
		));
		$this->add($city);

	}
}
