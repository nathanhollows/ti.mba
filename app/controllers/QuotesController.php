<?php

namespace App\Controllers;

use DataTables\DataTable;
use Phalcon\Security\Random;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Forms;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Models\Quotes;
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

	public function deleteAction($quoteId)
	{
		$this->view->disable;
	}

	public function newAction($customerCode = null)
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('blank');
		}
		$this->tag->prependTitle('New Quote');
		$this->view->quoteForm = new QuotesForm();
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
		$success = $quote->save($this->request->getPost(), array('date', 'customerCode', 'customerRef', 'user', 'contact', 'status'));
		if ($success) {
			$this->response->redirect('quotes/');
			$this->view->disable;
		} else {
			$this->flash->error("Sorry, the quote could not be saved");
			foreach ($quote->getMessages() as $message) {
				$this->flash->error($message->getMessage());
			}
		}
	}
}