<?php

namespace App\Controllers;

use App\Forms\CustomersForm,
	App\Form\EditCustomerForm,
	App\Models\Customers;

class CustomersController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{
		$this->persistent->conditions = null;
		$this->view->form = new CustomersForm();
	}

	public function searchAction()
	{

	}

	public function createAction()
	{

	}

	public function deleteAction()
	{

	}

	public function viewAction()
	{

	}
}