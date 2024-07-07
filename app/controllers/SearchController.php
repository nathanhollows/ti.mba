<?php

namespace App\Controllers;

use App\Models\Customers;
use App\Models\Contacts;
use Phalcon\Http\Response;
use Algolia\AlgoliaSearch\SearchClient;

class SearchController extends ControllerBase
{
    protected $algoliaClient;
    protected $customerIndex;
    protected $contactIndex;

    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();

        $config = $this->di->get('config');

        if (!empty($config->algolia->appID) && !empty($config->algolia->appKey)) {
            $this->algoliaClient = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $this->customerIndex = $this->algoliaClient->initIndex('customers');
            $this->contactIndex = $this->algoliaClient->initIndex('contacts');
        }
    }

    public function indexAction()
    {
        // Disable view rendering for this action
        $this->view->disable();

        // Get the search query from the POST request
        $query = $this->request->getPost('q');

        // Redirect to the qAction with the search query
        return $this->response->redirect('search/q/' . urlencode($query));
    }

    public function qAction($query = null)
    {
        if ($query !== null) {
            // Replace URL encoded space with a normal space
            $query = str_replace('%20', ' ', $query);
        }
        // If no query parameter, check for POST request query
        if ($this->request->has("query")) {
            $query = $this->request->getPost("query");
        }

        $useAlgolia = !empty($this->algoliaClient) && !empty($this->customerIndex) && !empty($this->contactIndex);

        if ($useAlgolia) {
            $customers = $this->algoliaSearch($query, $this->customerIndex);
            $contacts = $this->algoliaSearch($query, $this->contactIndex);
        } else {
            $customers = Customers::searchColumns($query);
            $contacts = Contacts::searchColumns($query);
        }

        // Handle live search requests
        if ($this->request->has('live')) {
            // Disable view rendering
            $this->view->disable();

            // Return false if query is too short
            if (strlen($query) < 3) {
                return false;
            }

            // Create a JSON response with search results
            $response = new Response();
            $response->setContentType('application/json');
            $responseContent = [
                "term" => $query,
                "results" => count($customers) + count($contacts),
                "customers" => json_decode(json_encode($customers)),
                "contacts" => json_decode(json_encode($contacts)),
            ];
            $response->setContent(json_encode($responseContent));
            return $response;
        }

        // Set page title
        $this->tag->prependTitle('Search');

        // Initialize view variables
        $this->view->query = '';
        $this->view->noResults = false;
        $this->view->noTerm = false;


        // If query is still null, set noTerm and noResults to true
        if ($query === null) {
            $this->view->noTerm = true;
            $this->view->noResults = true;
            return true;
        }

        // If query is too short, set noResults to true and show warning
        if (strlen(str_replace(' ', '', $query)) < 3) {
            $this->view->noResults = true;
            $this->flash->warning("Searches must contain more than 2 characters.");
            return true;
        }

        // Set query in view
        $this->view->query = $query;

        // Set contacts and customers in view
        $this->view->contacts = json_decode(json_encode($contacts));
        $this->view->customers = json_decode(json_encode($customers));

        // If no results found, set noResults to true
        if (count($contacts) == 0 && count($customers) == 0) {
            $this->view->noResults = true;
            return true;
        }
    }

    protected function algoliaSearch($query, $index)
    {
        if (strlen($query) < 3) {
            return [];
        }

        $results = $index->search($query);
        return $results['hits'];
    }
}
