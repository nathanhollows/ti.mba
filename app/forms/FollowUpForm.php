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

class FollowUpForm extends Form
{
	// Initialize the Follow Up form
	public function initialize($entity = null, $option = null)
	{
		$id = new Hidden("id");
		$this->add($id);
		
		$customer = new Select(
			"customerCode",
			Customers::find(
				array(
					"conditions"	=> "customerCode = ?1",
					"bind"			=> array(1 => $option["customerCode"]),
				)
			),
			array(
				'using'	=> array(
					'customerCode',
					'customerName',
				),
			'class'	=> 'form-control selectpicker',
			'data-live-search' => 'true',
			'useEmpty'	=> true
			)
		);
		$customer->setLabel("Customer");
		$this->add($customer);

		$contact = new Select(
			"contact",
			Contacts::find(
				array(
					"conditions"	=> "customerCode = ?1",
					"bind"			=> array(1 => $option["customerCode"]),
				)
			),
			array(
				'using'	=> array(
					'id',
					'name'
				),
			'class'	=> 'form-control selectpicker',
			'data-live-search' => 'true',
			'useEmpty'	=> true,
			)
		);
		$contact->setLabel("Contact");
		$this->add($contact);

		$job = new Text("job");
		$job->setAttributes(array(
			'class'		=> 'form-control',
			'placeholder'	=> 'Quote Number',
			));
		$job->setLabel("Job");
		$this->add($job);

		$details = new TextArea("details");
		$details->setAttributes(array(
			'class'		=> 'form-control markdown-edit',
			'data-provide'=>'markdown-editable',
			'autofocus'	=> 'true',
			'data-iconlibrary'=>'fa',
			));
		$details->setLabel("Details");
		$this->add($details);

		$theDate = date('Y-m-d');
		if (isset($option["followUpDate"])) {
			$theDate = $option["followUpDate"];
		}

		$date = new Text("followUpDate");
		$date->setAttributes(array(
			'value'		=> $theDate,
			'required'	=> 'true',
			'class'		=> 'form-control'
			));
		$date->setLabel("Date");
		$this->add($date);
		
		$auth = new Auth();

		$rep = new Select(
			"user",
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