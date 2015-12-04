<?php

namespace App\forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Hidden,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Submit,
	Phalcon\Forms\Element\Text;

use App\Models\CustomerGroups,
	App\Models\CustomerStatus,
	App\Models\SalesAreas,
	App\Models\FreightAreas,
	App\Models\FreightCarriers;

class CustomersForm extends Form
{
	// Initialize the customers form
	public function initialize()
	{
		if (!isset($options['edit'])) {
			$element = new Text("customerCode");
			$this->add($element->setLabel("Customer Code"));
		} else {
			$this->add(new Hidden("customerCode"));
		}
		
		$element->setFilters(array('striptags', 'string'));
		$element->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Customer Code'
			)
		);

		// Customer name
		// Text field
		$name = new Text("customerName");
		$name->setLabel("Customer Name");
		$name->setFilters(array('striptags', 'string'));
		$name->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Name'
			)
		);
		$this->add($name);

		// Customer phone
		// Text field
		$phone = new Text("customerPhone");
		$phone->setLabel("Phone Number");
		$phone->setFilters(array('striptags', 'string'));
		$phone->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Phone number',
			)
		);
		$this->add($phone);

		// Customer fax
		// Text field
		$fax = new Text("customerFax");
		$fax->setLabel("Fax Number");
		$fax->setFilters(array('striptags', 'string'));
		$fax->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Fax number',
			)
		);
		$this->add($fax);

		// Customer email
		// Text field
		$email = new Text("customerEmail");
		$email->setLabel("Email");
		$email->setFilters(array('striptags', 'string'));
		$email->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Email',
			)
		);
		$this->add($email);

		// Customer group
		// Select field
		$group = new Select(
			'customerGroup',
			CustomerGroups::find(),
			array(
				'using'		=> array('id', 'name'),
				'useEmpty'	=> true,
				'emptyTest'	=> '...',
				'emptyValue'=> '',
				'class'		=> 'form-control'
			)
		);
		$group->setLabel('Customer Group');
		$this->add($group);

		// Freight Area
		// Select field
		$freightArea = new Select(
			'freightArea',
			FreightAreas::find(),
			array(
				'using'		=> array('id', 'name'),
				'useEmpty'	=> true,
				'emptyTest'	=> '...',
				'emptyValue'=> '',
				'class'		=> 'form-control'
			)
		);
		$freightArea->setLabel('Freight Area');
		$this->add($freightArea);

		// Freight Carrier
		// Select field
		$freightCarrier = new Select(
			'freightCarrier',
			FreightCarriers::find(),
			array(
				'using'		=> array('id', 'name'),
				'useEmpty'	=> true,
				'emptyTest'	=> '...',
				'emptyValue'=> '',
				'class'		=> 'form-control'
			)
		);
		$freightCarrier->setLabel('Freight Carrier');
		$this->add($freightCarrier);

		// Customer status
		// Select field
		$status = new Select(
			'customerStatus',
			CustomerStatus::find(),
			array(
				'using'		=> array('id', 'name'),
				'useEmpty'	=> true,
				'emptyValue'=> '',
				'class'		=> 'form-control'
			)
		);
		$status->setLabel('Customer Status');
		$this->add($status);

		// Customer status
		// Select field
		$salesArea = new Select(
			'salesArea',
			SalesAreas::find(),
			array(
				'using'		=> array('id', 'name'),
				'useEmpty'	=> true,
				'emptyValue'=> '',
				'class'		=> 'form-control'
			)
		);
		$salesArea->setLabel('Sales Area');
		$this->add($salesArea);
	}

}