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

		$this->view->headerButton = \Phalcon\Tag::linkTo(array('quotes/new', 'New', 'class' => ' btn btn-default pull-right'));

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

	public function getAction($quoteId)
	{
		$this->view->disable();
		$quote = Quotes::findFirstByquoteId($quoteId);
		$snappy = new Pdf('C:\"Program Files"\wkhtmltopdf\bin\wkhtmltopdf.exe');
		// $snappy = new Pdf('xvfb-run -a /usr/bin/wkhtmltopdf');
		$snappy->setOptions(
			array(
				'header-html'	=> 'http://dev/quotes/header',
				'header-spacing'=> '10',
				'footer-html'	=> 'http://dev/quotes/footer',
				'footer-spacing'=> '10',
				'margin-top'	=> '44',
				'margin-bottom'	=> '20',
				'margin-left'	=> '0',
				'margin-right'	=> '0',
				'page-size'		=> 'A4',
				'disable-smart-shrinking'	=> true,
				'dpi'			=> '720',
				)
			);
		$response = new Response;
		// Setting a header by its name
		$response->setHeader("Content-Type", "application/pdf");
		$response->setHeader("Content-Disposition", 'inline; filename="' . $quote->quoteId . ' ' . $quote->customer->customerName . '"');
		$response->setContent($snappy->getOutput('dev/quote/' . $quote->webId ));
		$response->send();
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
		$this->view->dated  = strtotime($quote->date);

	}

	public function turntosaleAction($quoteId)
	{
		$this->view->disable();

		$quote = Quotes::findFirstByquoteId($quoteId);
		if ($quote->sale === 1){
			$quote->sale = 0;
		} else {
			$quote->sale = 1;
		}
		$quote->update();

		return $this->_redirectBack();
	}

	public function headerAction()
	{
		$this->view->setTemplateBefore("none");
	}	

	public function footerAction()
	{
		$this->view->setTemplateBefore("none");
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
		// Disable the view, this is an information processing action
		$this->view->disable();

		// If the user stubmles accross this page without having submitted data then forward them to the quotes index
		if (!$this->request->isPost()) {
			return $this->dispatcher->forward(array(
				"controller"	=> "quotes",
				"action"		=> "index"
				)
			);
		}

		$quote = Quotes::findFirstByquoteId($this->request->getPost('quoteId'));
		// Store and check for errors
		$success = $quote->update($this->request->getPost(), array('customerCode', 'contact', 'reference', 'date', 'notes', 'moreNotes', 'user', 'status'));
		if ($success) {
			$this->flash->success('Quote updated successfully');
			return $this->_redirectBack();
		} else {
			$this->flash->error('Sorry, the quote could not be updated');
			foreach($quote->getMessages() as $message) {
				$this->flash->error($message->getMessage());
			}
		}
	}

	public function addItemAction($id = null)
	{
		$this->view->setTemplateBefore('modal-form');
		$this->view->pageTitle = "Add a line";

		$item = new QuoteItems();
		$item->quoteId = $id;

		$form = new ItemForm($item);
		$this->view->form = $form;
	}

	public function createItemAction()
	{
		$this->view->disable();
		if (!$this->request->isPost()){
			$this->_redirectBack();
		}

		$item = new QuoteItems();

		$success = $item->save($this->request->getPost(), array('quoteId', 'width', 'thickness', 'grade', 'finish', 'lengths', 'priceUnit', 'unitPrice'));
		if ($success) {
			$this->flashSession->success('Item added!');
			return $this->_redirectBack();
		} else {
			$this->flashSession->error('Sorry, the item could not be added');
			foreach($item->getMessages() as $message) {
				$this->flashSession->error($message->getMessage());
			}
		}

	}

	public function editItemAction($id)
	{
		$this->view->disable();
		if (!$this->request->isPost()){
			$this->_redirectBack();
		}
	}

	public function deleteItemAction($id)
	{
		// Disable the view and redirect anyone visiting this page incorrectly
		$this->view->disable();
		if (!$this->request->isPost()){
			$this->_redirectBack();
		}

		// Find the quote item based on the id in the url
		$item = QuoteItems::findFirstById($id);

		// If the item does not exist
		if (!$item) {
			$this->flashSession->warning('Hmmm.. That item couldn\'t be found');
			$this->_redirectBack();
		}

		// Try to delete the item,
		// Flash the outcome to the session and redirect back
		if ($item->delete()) {
			$this->flashSession->info('Item was successfully deleted');
			$this->_redirectBack();
		} else {
			$this->flashSession->warning('Something went wrong and this item could not be deleted');
			$this->_redirectBack();
		}
	}

}