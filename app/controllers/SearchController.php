<?php

namespace App\Controllers;

use Phalcon\Tag;
use App\Models\Customers;
use App\Models\Quotes;
use App\Models\Contacts;
use App\Models\Orders;
use Phalcon\Http\Response;

class SearchController extends ControllerBase
{

	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
		$this->view->setViewsDir('/var/www/html/app/facelift/');
	}

	public function indexAction()
	{
		$this->view->disable();
		$query = $this->request->getPost('q');
		return $this->response->redirect('search/q/' . $query);
	}

	public function qAction($query = null)
	{
		$this->tag->prependTitle('Search');

		$this->view->query = '';
		$this->view->noHeader = true;
		$this->view->noResults = false;
		$this->view->noTerm = false;
		if (is_null($query) && $this->request->has("query")) {
			$query = $this->request->getPost("query");
		}
		if($query === null) {
			$this->view->noTerm = true;
			$this->view->noResults = true;
			return true;
		}
		if(strlen(str_replace(' ', '', $query)) < 3) {
			$this->view->noResults = true;
			$this->flash->warning("Searches must contain more than 2 characters.");
			return true;
		}
		$term = str_replace(' ', '%', $query);
		$this->view->query = $query;

		$contacts = Contacts::searchColumns($term);
		$customers = Customers::searchColumns($term);
		$quotes = Quotes::searchColumns($term);
		$orders = Orders::searchColumns($term);

		if(count($contacts) == 0 and count($customers) == 0 and count($quotes) == 0 ){
			$this->view->noResults = true;
			return true;
		}

		$this->view->contacts = $contacts;
		$this->view->customers = $customers;
		$this->view->quotes = $quotes;

	}
}
