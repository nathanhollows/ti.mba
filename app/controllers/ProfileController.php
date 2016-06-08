<?php

namespace App\Controllers;

use App\Auth\Auth;
use App\Models\Users;

class ProfileController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{
		if ($this->request->isAjax()) {
			print_r($this->request->getPost());
		}

			$auth = new Auth;
			$id = $auth->getId();

		$user = Users::findFirstByid($id);

		$this->view->pageTitle = $user->name;

		$this->view->user = $user;
	}
}