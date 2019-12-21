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

		if (isset($option["customerCode"])) {
			$conditions = array(
				"conditions"	=> "customerCode = ?1",
				"bind"			=> array(1 => $option['customerCode']),
			);
            $readonly = true;
            $class      = '';
		} else {
			$conditions = null;
            $readonly   = false;
            $class    = 'selectpicker';
		}

		$customer = new Select(
			"customerCode",
			Customers::find($conditions),
			array(
				'using'	=> array(
					'customerCode',
					'customerName',
				),
				'class'	=> "form-control $class",
				'data-live-search' => 'true',
				'useEmpty'	=> true,
                'readonly'  => $readonly,
			)
		);
		$customer->setLabel("Customer");
		$this->add($customer);

		$contact = new Select(
			"contact",
			Contacts::find($conditions),
			array(
				'using'	=> array(
					'id',
					'name'
				),
			'class'	=> 'form-control selectpicker',
			'data-live-search' => 'true',
			'useEmpty'	=> true,
            'emptyText' => 'Select a Contact...',
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

		$reference = new Text("reference");
		$reference->setAttributes(array(
			'class'		=> 'form-control',
			'placeholder'	=> 'Reference',
			));
		$reference->setLabel("Reference");
		$this->add($reference);

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

        $recordDate = new Date('date');
        $recordDate->setAttributes(array(
            'required'      => 'true',
            'class'		=> 'form-control'
        ));
        $this->add($recordDate);

		$auth = new Auth();

		$rep = new Select(
			"user",
			Users::getActive(),
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
