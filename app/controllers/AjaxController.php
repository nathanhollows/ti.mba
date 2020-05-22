<?php

namespace App\Controllers;

class AjaxController extends ControllerBase
{
    public function initialize()
    {
        $this->view->disable();
        parent::initialize();
    }

    public function indexAction()
    {
        if ($this->request->isAjax()) {
            print_r($this->request->getPost());
        }
    }
}
