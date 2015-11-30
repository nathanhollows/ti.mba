<?php

namespace App\forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Hidden,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Submit,
	Phalcon\Forms\Element\Text;

use App\Models\CustomerGroups,
	App\Models\CustomerStatus,
	App\Models\SalesAreas;

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

		$name = new Text("customerName");
		$name->setLabel("Customer Name");
		$name->setFilters(array('striptags', 'string'));
		$name->setFilters(array('striptags', 'string'));
		$name->setAttributes(array(
			'class'			=> 'form-control',
			'placeholder'	=> 'Name'
			)
		);
		$this->add($name);

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
	}

}