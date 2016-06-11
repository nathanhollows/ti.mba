<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Hidden,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Date;
use App\Models\OrderLocations;

class OrdersForm extends Form
{
	// Initialize the Follow Up form
	public function initialize($entity = null, $option = null)
	{

		$orderNumber = new Hidden('orderNumber');
		$this->add($orderNumber);

		$eta = new Date('eta');
		$eta->setAttributes(array(
			'class'	=> 'form-control',
			'value'	=> date("Y-m-d"),
		));
		$eta->setLabel('ETA Date');
		$this->add($eta);

		$location = new Select(
			'location',
			OrderLocations::find(),
			array(
				'using' => array('id', 'name'),
				'class' => 'form-control',
				'useEmpty'	=> true,
			)
		);
		$this->add($location);

	}
}