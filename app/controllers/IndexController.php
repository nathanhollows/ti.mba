<?php

namespace App\Controllers;

use Phalcon\Tag;

class IndexController extends ControllerBase
{
    public function indexAction()
    {
        $this->view->disable();
        $this->response->redirect('dashboard');
    }
}
