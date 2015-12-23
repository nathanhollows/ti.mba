<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;

use App\Models\Users;

class QuotesForm extends Form
{

	/**
	 * Initiliaze the quotes form
	 */

	public function initialize()
	{
		$customerCode = new Text("customerCode");
		$customerCode->setLabel("Customer");
		$this->add($customerCode);

		$salesAgent = new Select(
			"salesagent",
			Users::find(),
			array(
				'using'	=> array(
					'id',
					'name'
				)
			)
		);
		$salesAgent->setLabel("Sales Agent");	
		$salesAgent->setDefault('3');
		$this->add($salesAgent);
	}
}