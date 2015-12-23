<?php

namespace App\Controllers;

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
	}

	public function viewAction($quoteId)
	{
		$this->view->setTemplateBefore('quote');
		$this->tag->prependTitle('Quote ' . strip_tags($quoteId));
	}

	public function deleteAction($quoteId)
	{

	}

	public function newAction($customerCode = null)
	{
		$this->tag->prependTitle('New Quote');
		$this->form = new QuotesForm($customerCode);
	}
}