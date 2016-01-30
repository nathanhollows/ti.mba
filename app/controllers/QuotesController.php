<?php

namespace App\Controllers;

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
		$this->tag->prependTitle('Quotes');
		$quotes = new Quotes;
	}

	public function viewAction($quoteId)
	{
		$quote = Quotes::findFirstBywebId($quoteId);
		if ($quote) {
			$this->view->setTemplateBefore('quote');
		} else {
			return "Panic!";
		}
		$this->view->quote = $quote;
		$this->tag->prependTitle('Quote ' . strip_tags($quoteId));
	}

	public function deleteAction($quoteId)
	{
		$this->view->disable;
	}

	public function newAction($customerCode = null)
	{
		$this->tag->prependTitle('New Quote');
		$this->view->quoteForm = new QuotesForm();
	}

	public function createAction()
	{
		$this->view->disable;
	}
}