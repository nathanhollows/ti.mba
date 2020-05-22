<?php

namespace App\Controllers;

class ReturnController extends ControllerBase
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
        } else {
            echo "<pre>";
            echo print_r($this->request->getPost());
            echo "</pre>";
        }
    }
}
