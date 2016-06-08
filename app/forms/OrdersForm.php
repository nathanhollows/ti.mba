<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\Date;

class OrdersForm extends Form
{
	// Initialize the Follow Up form
	public function initialize($entity = null, $option = null)
	{

		$eta = new Date('eta');
		$eta->setAttributes(array(
			'class'	=> 'form-control',
			'value'	=> '12-34-5678'
		));
		$eta->setLabel('ETA Date');
		$this->add($eta);
	}
}