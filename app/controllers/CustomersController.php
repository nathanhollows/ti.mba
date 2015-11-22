<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria,
	Phalcon\Paginator\Adapter\Model as Paginator;

use App\Forms\CustomersForm,
	App\Form\EditCustomerForm,
	App\Models\Customers as Customers;

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
		$this->tag->prependTitle('Search Customers');
		$numberPage = 1;
		if ($this->request->isPost()) {
			$query = Criteria::fromInput($this->di, 'App\Models\Customers', $this->request->getPost());
			$this->persistent->searchParams = $query->getParams();
		} else {
			$numberPage = $this->request->getQuery("page", "int");
		}

		$parameters = array();
		if ($this->persistent->searchParams) {
			$parameters = $this->persistent->searchParams;
		}

		$customers = Customers::find($parameters);
		if (count($customers) == 0) {
			$this->flash->notice("There are no customers that meet these criteria");
			return $this->dispatcher->forward(array(
				"action"	=> "index"
			));
		}

		$paginator = new Paginator(array(
			"data"	=> $customers,
			"limit"	=> 10,
			"page"	=> $numberPage
		));

		$this->view->page = $paginator->getPaginate();
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