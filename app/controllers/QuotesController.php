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
use App\Forms\QuotesForm;

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
		if ($this->request->isAjax()) {
			$builder = $this->modelsManager->createBuilder()
			->columns('id, date, customerCode, customerRef, user, contact, status')
			->from('App\Models\Quotes')
			->orderBy('id');

			$dataTables = new DataTable();
			$dataTables->fromBuilder($builder)->sendResponse();
			$this->persistent->parameters = null;
		};

		$quotes = Quotes::find();
		$this->view->quotes = $quotes;
	}

	public function viewAction($quoteId = null)
	{
		$quote = Quotes::findFirstBywebId($quoteId);
		if ($quote) {
			$this->tag->prependTitle('Quote');
			$this->view->setTemplateBefore('quote');
			$this->view->quote = $quote;
		} else {
			// If the quote does not exist then send the user to a 404 page
			$this->response->redirect('error');
		}
	}

	public function editAction($quoteId = null)
	{
		$quote = Quotes::findFirstByid($quoteId);
		if ($quote) {
			$this->tag->prependTitle('Quote');
			$this->view->quote = $quote;
			$items = QuoteItems::Find(array(
				"conditions"	=> "quoteId = ?1",
				"bind"			=> array(
					1			=> $quoteId
					)
				));
			$this->view->items = $items;
		} else {
			// If the quote does not exist then spit out an error
			$this->flash->error("That quote doesn't exist! Weird.");
			$this->dispatcher->forward(array(
				"controller"	=> "quotes",
				"action"		=> ""
				));
		}
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
		$quote->webId = $random->base64Safe(6);
		// Store and check for errors
		$success = $quote->save($this->request->getPost(), array('date', 'customerCode', 'customerRef', 'details', 'user', 'contact', 'status'));
		if ($success) {
			$this->flash->success("Quote created successfully!");
			return $this->dispatcher->forward(array(
				"controller"	=> "quotes",
				"action"		=> "edit",
				"params"		=> array($quote->id)
				));
		} else {
			$this->flash->error("Sorry, the quote could not be saved");
			foreach ($quote->getMessages() as $message) {
				$this->flash->error($message->getMessage());
			}
		}
	}
}