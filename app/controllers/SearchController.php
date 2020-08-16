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
		if (!is_null($query)) {
			$query = str_replace('%20', ' ', $query);
		}
		if ($this->request->has('live')) {
			$this->view->disable();
			if (strlen($query) < 3) {
				return false;
			}
			$customers = Customers::searchColumns($query);

			$response = new \Phalcon\Http\Response();
			$response->setContentType('application/json');
			$content = json_encode([
				"term" => $query,
				"results" => count($customers),
				"customers" => $customers->jsonSerialize(),
			]);
			$response->setContent($content);
			return $response;
		}

        $this->tag->prependTitle('Search');

        $this->view->query = '';
        $this->view->noResults = false;
        $this->view->noTerm = false;
        if (is_null($query) && $this->request->has("query")) {
            $query = $this->request->getPost("query");
        }
        if ($query === null) {
            $this->view->noTerm = true;
            $this->view->noResults = true;
            return true;
        }
        if (strlen(str_replace(' ', '', $query)) < 3) {
            $this->view->noResults = true;
            $this->flash->warning("Searches must contain more than 2 characters.");
            return true;
        }
        $this->view->query = $query;

        $contacts = Contacts::searchColumns($query);
        $customers = Customers::searchColumns($query);
        $quotes = Quotes::searchColumns($query);
        $orders = Orders::searchColumns($query);


        $this->view->contacts = $contacts;
        $this->view->customers = $customers;
        $this->view->quotes = $quotes;

        if (count($contacts) == 0 and count($customers) == 0 and count($quotes) == 0) {
            $this->view->noResults = true;
            return true;
        }
    }
}
