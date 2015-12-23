<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;

class QuotesForm extends Form
{

	/**
	 * Initiliaze the quotes form
	 */

	public function initialize($customerCode = null)
	{
		$customerCode = new Text("customerCode");
		$this->add($customerCode);
	}
}