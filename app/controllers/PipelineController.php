<?php

namespace App\Controllers;

use App\Models\Quotes;
use App\Models\Users;

class PipelineController extends ControllerBase
{

	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{
		$this->view->pageTitle = "Pipeline";
		$this->tag->prependTitle("Pipeline");

		$this->view->headerButton = '
		<button class="btn btn-info pull-right" type="button" data-toggle="collapse" data-target="#help" aria-expanded="false" aria-controls="collapseExample">
		  Help
		</button>
		';

		$quotes = new Quotes;

		$this->view->users = Users::listUsers();
        $this->view->user  = $this->session->get('auth-identity')['name'];

		$this->view->hot 	= $quotes->getByStatus(1);
		$this->view->warm 	= $quotes->getByStatus(2);
		$this->view->cold 	= $quotes->getByStatus(3);

		$this->view->hotValue 	= $quotes->valueByStatus(1);
		$this->view->warmValue 	= $quotes->valueByStatus(2);
		$this->view->coldValue 	= $quotes->valueByStatus(3);

		$this->view->hotCount 	= $quotes->countByStatus(1);
		$this->view->warmCount 	= $quotes->countByStatus(2);
		$this->view->coldCount 	= $quotes->countByStatus(3);

		$this->assets->collection("footer")
			->addJs("//cdnjs.cloudflare.com/ajax/libs/Sortable/1.4.2/Sortable.min.js")
			->addJs("//cdnjs.cloudflare.com/ajax/libs/hideseek/0.7.1/jquery.hideseek.min.js");
	}

	public function updatestatusAction()
	{
		if (!$this->request->isAjax()) {
			$this->response->redirect('/projects');
		}
		$this->view->disable();

		$list = $this->request->getPost();

		if ($this->request->isAjax()) {
			print_r($list);
		} else {
			echo "<pre>";
			echo print_r($list);
			echo "</pre>";
		}

		if (is_numeric($list['quote'])) {
			$quote = Quotes::findFirstByquoteId($list['quote']);
		}

		if (is_numeric($list['status'])) {
			$quote->status = $list['status'];
			$quote->save();
		}

	}

	public function saleAction($quoteId)
	{
		$this->view->disable();

		$quote = Quotes::findFirstByquoteId($quoteId);
		$quote->sale = 1;
		$quote->status = 4;
		$quote->update();
	}

}
