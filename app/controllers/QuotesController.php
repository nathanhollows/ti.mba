<?php

namespace App\Controllers;

use DataTables\DataTable;
use Phalcon\Security\Random;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Forms;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Models\Quotes;
use App\Models\QuoteItems;
use App\Models\GenericStatus;
use App\Forms\quotes\QuotesForm;
use App\Forms\quotes\ItemForm;
use Knp\Snappy\Pdf;
use Phalcon\Http\Response;

class QuotesController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{

		$this->tag->prependTitle('Search Quotes');
		$this->view->pageSubtitle = "Search";
		$this->flash->warning("Searching by Rep and Status do not currently work");

		$this->assets->collection('footer')
			->addJs('js/datatables/quotes.js');
	}

	public function ajaxAction($customerCode = NULL)
	{
		if ($this->request->isAjax()) {
			$builder = $this->modelsManager->createBuilder()
			->columns('quoteId, date, customerCode, reference, user, attention, status, quoteStatus.style, quoteStatus.name, rep.name AS salesRep')
			->from('App\Models\Quotes')
			->join('App\Models\GenericStatus', 'status = quoteStatus.id', 'quoteStatus', 'INNER')
			->join('App\Models\Users', 'user = rep.id', 'rep', 'INNER');

			if (isset($customerCode)) {
				$builder->where("customerCode = '$customerCode'");
			}

			$dataTables = new DataTable();
			$dataTables->fromBuilder($builder)->sendResponse();
			$this->persistent->parameters = null;
		};
	}

	public function publicAction($quoteId = null)
	{
		$quote = Quotes::findFirstBywebId($quoteId);
		$items = QuoteItems::find("quoteId = $quote->quoteId");

		if (!$quote) {
			// If the quote does not exist then send the user to a 404 page
			$this->response->redirect('error');
		}

		$this->tag->prependTitle('Quote');
		$this->view->setTemplateBefore('quote');
		$this->view->quote = $quote;
		$this->view->items = $items;

	}

	public function viewAction($quoteId = null)
	{
		$quote = Quotes::findFirstByquoteId($quoteId);
		if (!$quote) {
			// If the quote does not exist then spit out an error
			$this->flash->error("That quote doesn't exist! Weird.");
			$this->dispatcher->forward(array(
				"controller"	=> "quotes",
				"action"		=> ""
				));
		}

		$this->tag->prependTitle('Quote');
		$this->view->quote = $quote;
		$items = QuoteItems::Find(array(
			"conditions"	=> "quoteId = ?1",
			"bind"			=> array(
				1			=> $quoteId
				)
			));
		if ($this->view->quote->sale == "1") {
			$this->flash->notice("This quote has been turned into a sale");
		}
		$this->view->items = $items;
	}

	public function editAction($quoteId = null)
	{
		$this->view->setTemplateBefore('modal-form');

		$this->view->pageTitle = "Edit quote details";

		if (!$quoteId) {
			$this->flash->error("Error: Missing the Quote ID");
			return true;
		}

		$quote = Quotes::findFirstByquoteId($quoteId);
		$form = new QuotesForm($quote);
		$this->view->form = $form;
	}

	public function deleteAction($quoteId)
	{
		$this->view->disable;
	}

	public function newAction($customerCode = null)
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		$this->view->pageTitle = "Create a Quote";

		$quote = new Quotes;

		if (null !== ($this->request->getQuery('company'))) {
			$quote->assign(array(
				'customerCode'	=> $this->request->getQuery('company')
				)
			);
		}		

		if (null !== ($this->request->getQuery('contact'))) {
			$quote->assign(array(
				'contact'	=> $this->request->getQuery('contact')
				)
			);
		}

		$this->tag->prependTitle('New Quote');
		$this->view->quoteForm = new QuotesForm($quote);
	}

	public function createAction()
	{
		if (!$this->request->isPost()) {
			return $this->dispatcher->forward(array(
				"controller"	=> "quotes",
				"action"		=> "index"
				)
			);
		}

		$quote = new Quotes();
		$random = new Random();
		$quote->webId = $random->uuid();
		// Store and check for errors
		$success = $quote->save($this->request->getPost(), array('date', 'customerCode', 'customerRef', 'details', 'user', 'contact', 'status'));
		if ($success) {
			$this->flashSession->success("Quote created successfully!");
			return $this->response->redirect("quotes/edit/" . $quote->id);
		} else {
			$this->flash->error("Sorry, the quote could not be saved");
			foreach ($quote->getMessages() as $message) {
				$this->flash->error($message->getMessage());
			}
		}
	}

	public function updateAction() {
		
	}

	public function itemAction($id = null)
	{
		$this->view->setTemplateBefore('modal-form');
		$this->view->pageTitle = "Add a line";
		$form = new ItemForm();
		$this->view->form = $form;
	}
}