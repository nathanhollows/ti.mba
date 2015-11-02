<?php

namespace App\Controllers\Admin;

use Phalcon\Mvc\Controller,
	Phalcon\Tag;

class ControllerBase extends Controller
{

	protected function initialize()
	{
		Tag::appendTitle(' | ' . SITE_TITLE);

	}

	public function afterExecuteRoute()
	{
		$this->view->setViewsDir($this->view->getViewsDir() . 'admin/');
	}
}