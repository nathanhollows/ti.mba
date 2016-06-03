<?php

namespace App\Controllers;

use App\Models\Quotes;

class ProjectsController extends ControllerBase
{

	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{

		$quotes = new Quotes;

		$this->view->hot = $quotes->gethot();
		$this->view->warm = $quotes->getWarm();
		$this->view->cold = $quotes->getCold();

		$this->assets->collection("footer")
			->addJs("//cdnjs.cloudflare.com/ajax/libs/Sortable/1.4.2/Sortable.min.js")
			->addJs("//cdnjs.cloudflare.com/ajax/libs/hideseek/0.7.1/jquery.hideseek.min.js");
	}

}