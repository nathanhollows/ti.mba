<?php

namespace App\Controllers;

use Phalcon\Tag;
use App\Models\Budgets;
use Phalcon\Http\Response;

class BudgetController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('none');
        parent::initialize();
	}

    public function updateAction()
    {
    	$response = new Response();

    	if (!$this->request->isAjax()) {
    		$response->setStatusCode(400, "Must be an AJAX request");
    		$response->setContent("I'm a teapot");
    		$response->send();
    	}

    	$budget = Budgets::findFirstByDate($this->request->get("pk"));
    	if (!$budget) {
    		$budget = new Budgets();
    		$budget->date = date("Y-m-d", strtotime($this->request->get("pk")));
    		$budget->year = date("Y", strtotime($this->request->get("pk")));
    		$budget->month = date("m", strtotime($this->request->get("pk")));
    	}
		if ($this->request->get("name", "string") == "budget") {
			$budget->budget = $this->request->get("value", "int");
		} else if ($this->request->get("name", "string") == "days") {
			$budget->days = $this->request->get("value", "int");
		} else {
	    	$response->setStatusCode(404, "Not Found");
	    	$response->setContent("Could not find resource");
	    	$response->send();
		}

		if ($budget->save()) {
	    	$response->setStatusCode(200, "OK");
	    	$response->setContent("Updated");
	    	$response->send();
		} else {
	    	$response->setStatusCode(404, "Not Found");
	    	$response->setContent("Could not be updated");
	    	$response->send();
		}

    }
}
