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

	// The start action, this shows the default 'search' view
	public function indexAction()
	{
		$this->tag->prependTitle('Customers');
		$this->persistent->searchParams	= null;
		$this->view->form 				= new CustomersForm;
	}

	// Executes the search based on the criteria sent from the index
	// Returning a paginator for the results
	public function searchAction()
	{

	}

	// Shows the view the create a new product
	public function newAction()
	{
		$this->tag->prependTitle('New Customer');

	}

	// Creates a cusomer based on the data entered into the new action
	public function createAction()
	{

	}

	// Shows the view to edit an existing customer
	public function editAction()
	{

	}

	// Updates a customer based on the data entered in the edit action
	public function saveAction()
	{

	}

	// Deletes and existing customer
	public function deleteAction()
	{

	}

}