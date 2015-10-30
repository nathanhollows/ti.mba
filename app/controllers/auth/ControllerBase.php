<?php

namespace App\Controllers\Auth;

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
		$this->view->setViewsDir($this->view->getViewsDir() . 'auth/');
	}
}