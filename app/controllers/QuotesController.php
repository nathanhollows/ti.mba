<?php

namespace App\Controllers;

use DataTables\DataTable;
use Phalcon\Security\Random;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Forms;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Auth\Auth;
use App\Models\Quotes;
use App\Models\QuoteItems;
use App\Models\GenericStatus;
use App\Models\Grade;
use App\Models\Treatment;
use App\Models\Users;
use App\Models\Dryness;
use App\Models\ContactRecord;
use App\Models\Finish;
use App\Models\QuoteVisits;
use App\Models\PricingUnit;
use App\Forms\quotes\QuotesForm;
use App\Forms\quotes\ItemForm;
use Knp\Snappy\Pdf;
use Phalcon\Http\Response;

class QuotesController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction($status = null)
    {
        $this->view->setViewsDir('/var/www/html/app/facelift/');
        $this->tag->prependTitle('Search Quotes');
        $this->view->pageSubtitle = "Search";
        $this->view->users = Users::getActive();

        $this->assets->collection('footer')
                // DataTables
                ->addJs('js/datatables/jquery.dataTables.min.js')
                ->addJs('js/datatables/dataTables.bootstrap.min.js')
            // View specific JS
            ->addJs('js/datatables/quotes.js?v=2.1');

        $this->view->headerButton = \Phalcon\Tag::linkTo(array('quotes/new', 'New', 'class' => ' btn btn-default pull-right'));
    }

    public function ajaxAction($customerCode = null)
    {
        if ($this->request->isAjax()) {
            $builder = $this->modelsManager->createBuilder()
            ->columns('quoteId, date, q.customerCode, b.customerName, reference, user, status, s.style, s.statusName, r.name, c.name as attention')
            ->addFrom('App\Models\Quotes', 'q')
            ->join('App\Models\GenericStatus', 's.id = status', 's')
            ->join('App\Models\Users', 'user = r.id', 'r')
            ->join('App\Models\Customers', 'q.customerCode = b.customerCode', 'b')
            ->leftJoin('App\Models\Contacts', 'c.id = contact', 'c');

            if (isset($customerCode)) {
                $builder->where("customerCode = '$customerCode'");
            }

            $dataTables = new DataTable();
            $dataTables->fromBuilder($builder)->sendResponse();
            $this->persistent->parameters = null;
        };
    }

    public function publicAction($quoteId = null)
    {
        $quote = Quotes::findFirstByquoteId($quoteId);
        $items = QuoteItems::find("quoteId = $quote->quoteId");

        if (!$quote) {
            // If the quote does not exist then send the user to a 404 page
            $this->response->redirect('error');
        }

        $this->tag->prependTitle('Quote');
        $this->view->setTemplateBefore('quote');
        $this->view->quote = $quote;
        $this->view->items = $items;
        $this->view->dated  = strtotime($quote->date);
    }

    public function turntosaleAction($quoteId)
    {
        $this->view->disable();

        $quote = Quotes::findFirstByquoteId($quoteId);
        $quote->sale = 1;
        $quote->status = 5;
        $quote->update();

        foreach ($quote->history as $record) {
            $record->complete();
        }

        return $this->_redirectBack();
    }

    public function quotelostAction($quoteId)
    {
        $this->view->disable();

        $quote = Quotes::findFirstByquoteId($quoteId);
        $quote->sale = 0;
        $quote->status = 4;
        $quote->update();

        foreach ($quote->history as $record) {
            $record->complete();
        }

        return $this->_redirectBack();
    }

    public function headerAction()
    {
        $this->view->setTemplateBefore("none");
    }

    public function footerAction()
    {
        $this->view->setTemplateBefore("none");
    }

    public function viewAction($quoteId = null)
    {
        $quote = Quotes::findFirstByquoteId($quoteId);
        if (!$quote) {
            // If the quote does not exist then spit out an error
            $this->flashSession->error("That quote doesn't exist! Weird.");
            return $this->response->redirect('/quotes');
        }

        $auth = new Auth();
        $visit = new QuoteVisits();
        $visit->user = $auth->getId();
        $visit->quoteId = $quote->quoteId;
        $visit->save();

        $item = new QuoteItems();
        $item->quoteId = $quote->quoteId;
        $this->view->form = new ItemForm($item);

        $this->tag->prependTitle('Quote ' . $quote->quoteId . " " . $quote->reference);
        $this->view->quote = $quote;
        $items = QuoteItems::Find(array(
            "conditions"	=> "quoteId = ?1",
            "bind"			=> array(
                1			=> $quoteId
            )
        ));
        if ($quote->sale == 1) {
            $this->flash->notice("This quote has been turned into a sale");
        }
        $this->view->items = $items;

        $quote->updateValue();

        $this->view->history = ContactRecord::find(array(
            'conditions'	=> "job = :quote:",
            'bind' => [
                'quote'	=> $quote->quoteId,
            ],
        ));

        $this->view->pageSubtitle = $quote->reference;
        $this->view->pageTitle = "Quote " . $quote->quoteId;
        $this->view->pageSubheader = (object) array(
            '1' => array(
                'icon' => 'usd',
                'text' => number_format($quote->value, 0),
            ),
            '2' => array(
                'icon' => 'user',
                'text' => ($quote->customerContact ? $quote->customerContact->name : $quote->attention),
                'link' => '/contacts/view/' . ($quote->customerContact ? $quote->customerContact->id : ''),
            ),
            '3' => array(
                'icon' => 'building',
                'text' => $quote->customer->customerName,
                'link' => '/customers/view/' . $quote->customerCode,
            ),
            '4' => array(
                'icon' => 'phone',
                'text' => $quote->customer->phone,
                'link' => 'tel:' . str_replace(' ', '', $quote->customer->phone),
                'link-class'=> 'tel-link'
            ),
        );
        $this->view->headerButton = '
		<!-- Split button -->
		<div class="btn-group pull-right">
			<a class="btn btn-success" href="/quotes/turntosale/' . $quote->quoteId . '" role="button">Won</a>
			<a class="btn btn-danger" href="/quotes/quotelost/' . $quote->quoteId . '" role="button">Lost</a>
			<a class="btn btn-default" href="/quote/get/' . $quote->webId . '" target="_blank"><i class="fa fa-icon fa-download"></i> Get PDF</a>
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="caret"></span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul class="dropdown-menu">
				<li><a data-target="#modal-ajax" href="/followup/?company=' . $quote->customerCode . '&job=' . $quote->quoteId . '" role="button"> Add Record</a></li>
				<li role="separator" class="divider"></li>
				<li><a href="#" data-href="/quotes/delete/' . $quote->quoteId . '" data-toggle="modal" data-target="#confirm-delete">Delete</a></li>
			</ul>
		</div>
		';

        $this->view->grades = Grade::find(array('order'	=> 'name ASC'));
        $this->view->treatment = Treatment::find(array('order'	=> 'name'));
        $this->view->dryness = Dryness::find(array('order'	=> 'name'));
        $this->view->finishes = Finish::find(array('order'	=> 'name'));
        $this->view->priceMethod = PricingUnit::find();
        $this->view->users = Users::getActive();

        $this->assets->collection('footer')
            ->addJs('js/to-markdown.js', true)
            ->addJs('js/bootstrap-markdown.js', true)
            ->addJs('js/markdown.js', true)
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.2/js/standalone/selectize.min.js')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/jquery.AreYouSure/1.9.0/jquery.are-you-sure.min.js')
            ->addJs('https://npmcdn.com/navigable-table@1.0.4/dist/navigable-table.js')
            ->addJs('js/editable-table.js', true);
        $this->assets->collection('header')
            ->addCss('css/bootstrap-markdown.min.css', true)
            ->addCss('https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.2/css/selectize.bootstrap3.min.css')
            ->addCss('https://npmcdn.com/editable-table/dist/editable-table.css');
    }

    public function editAction($quoteId = null)
    {
        $this->view->ajax = false;

        if ($this->request->isAjax()) {
            $this->view->ajax = true;
            $this->view->setTemplateBefore('modal-form');
        }


        if (!$quoteId) {
            $this->flash->error("Error: Missing the Quote ID");
            return true;
        }

        $quote = Quotes::findFirstByquoteId($quoteId);
        $options = array(
            "customerCode"	=> $quote->customerCode,
        );
        $form = new QuotesForm($quote, $options);
        $this->view->form = $form;

        $this->view->pageTitle = "Editing quote " . $quote->quoteId;
    }

    public function deleteAction($quoteId)
    {
        $this->view->disable();
        $quote = Quotes::findFirstByquoteId($quoteId);
        if ($quote != false) {
            if ($quote->delete() == false) {
                $this->flashSession->error("The quote has not been deleted");
            } else {
                $this->flashSession->success("The quote has been deleted");
            }
        } else {
            $this->flashSession->error("The quote could not be found");
        }
        return $this->response->redirect("quotes/");
    }

    public function newAction($customerCode = null)
    {
        $this->view->setViewsDir('/var/www/html/app/facelift/');
        $this->view->ajax = false;

        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
            $this->view->ajax = true;
        }

        $this->view->pageTitle = "Create a Quote";

        $quote = new Quotes;

        if (null !== ($this->request->getQuery('company'))) {
            $quote->assign(
                array(
                'customerCode'	=> $this->request->getQuery('company')
                )
            );
        }

        if (null !== ($this->request->getQuery('contact'))) {
            $quote->assign(
                array(
                'contact'	=> $this->request->getQuery('contact')
                )
            );
        }

        $this->tag->prependTitle('New Quote');
        $this->view->form = new QuotesForm($quote);
    }

    public function manageAction()
    {
        parent::initialize();
        $this->view->setViewsDir('/var/www/html/app/facelift/');
        $this->tag->prependTitle("Manage Quotes");
        $this->view->quotes = Quotes::find([
            "conditions"	=> "user = ?1 AND status != 4",
            "bind"				=> [
                1 => $this->auth->getId(),
            ],
            "order"	=> "quoteId DESC",
        ]);

        $this->view->value = Quotes::sum([
            "column"			=> "value",
            "conditions"	=> "user = ?1 AND status != 4",
            "bind"				=> [
                1 => $this->auth->getId(),
            ],
        ]);
    }

    public function createAction()
    {
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(
                array(
                "controller"	=> "quotes",
                "action"		=> "index"
                )
            );
        }

        $quote = new Quotes();
        $random = new Random();
        // Store and check for errors
        $quote->webId = $random->uuid();
        $success = $quote->save($this->request->getPost(), array('date', 'customerCode', 'reference', 'notes', 'user', 'contact', 'moreNotes'));
        if ($success) {
            $this->flashSession->success("Quote created successfully!");
            return $this->response->redirect("quotes/view/" . $quote->quoteId);
        } else {
            $this->flash->error("Sorry, the quote could not be saved");
            foreach ($quote->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }

    public function updateAction()
    {
        // Disable the view, this is an information processing action
        $this->view->disable();

        // If the user stubmles accross this page without having submitted data then forward them to the quotes index
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(
                array(
                "controller"	=> "quotes",
                "action"		=> "index"
                )
            );
        }

        $quote = Quotes::findFirstByquoteId($this->request->getPost('quoteId'));
        // Store and check for errors
        $success = $quote->update($this->request->getPost(), array('customerCode', 'contact', 'reference', 'date', 'notes', 'moreNotes', 'user', 'status'));
        if ($success) {
            $this->flash->success('Quote updated successfully');
            return $this->_redirectBack();
        } else {
            $this->flash->error('Sorry, the quote could not be updated');
            foreach ($quote->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }

    public function ajaxUpdateAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        $response = new \Phalcon\Http\Response();

        $quote = Quotes::findFirstByquoteId($this->request->getPost("pk"));
        switch ($this->request->getPost('name')) {
            case 'notes':
                $quote->notes = $this->request->getPost('value');
                break;
            case 'moreNotes':
                $quote->moreNotes = $this->request->getPost('value');
                break;
            case 'leadTime':
                $quote->leadTime = $this->request->getPost('value');
                break;
            case 'rep':
                $quote->user = $this->request->getPost('value');
                break;
            case 'validity':
                $quote->validity = $this->request->getPost('value');
                break;
            case 'date':
                $quote->date = $this->request->getPost('value');
                break;
            case 'reference':
                $quote->reference = $this->request->getPost('value');
                break;
            case 'freight':
                $quote->freight = $this->request->getPost('value');
                break;
            default:
                $response->setStatusCode(404, "Field not found");
                $response->send();
        }

        if ($quote->update()) {
            $response->setStatusCode(200, "Update successful");
        } else {
            $response->setStatusCode(500, "Something went wrong");
        }
        $response->send();
    }

    public function addItemAction($id = null)
    {
        $this->view->setTemplateBefore('modal-form');
        $this->view->pageTitle = "Add a line";

        $item = new QuoteItems();
        $item->quoteId = $id;

        $form = new ItemForm($item);
        $this->view->form = $form;
    }

    public function createItemAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }
        echo "<pre>" . print_r($this->request->getPost()) . "</pre>";
        $item = new QuoteItems();

        $item->quoteId  = $this->request->getPost('quoteId');
        $item->width  = $this->request->getPost('width');
        $item->thickness  = $this->request->getPost('thickness');
        $item->grade  = $this->request->getPost('grade');
        $item->finish  = $this->request->getPost('finish');
        $item->lengths  = $this->request->getPost('lengths');
        $item->priceUnit  = $this->request->getPost('priceMethod');
        $item->unitPrice  = $this->request->getPost('price');
        $item->qty  = $this->request->getPost('qty');
        $success = $item->save();
        if ($success) {
            $this->flashSession->success('Item added!');
            return $this->_redirectBack();
        } else {
            $this->flashSession->error('Sorry, the item could not be added');
            foreach ($item->getMessages() as $message) {
                $this->flashSession->error($message->getMessage());
            }
        }
    }

    public function editItemAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        $item = QuoteItems::findFirstById($this->request->getPost("pk"));
        switch ($this->request->getPost('name')) {
            case 'grade':
                $item->grade = $this->request->getPost('value');
                break;
            case 'width':
                $item->width = $this->request->getPost('value');
                break;
            case 'thickness':
                $item->thickness = $this->request->getPost('value');
                break;
            case 'finish':
                $item->finish = $this->request->getPost('value');
                break;
            case 'lengths':
                $item->lengths = $this->request->getPost('lengths');
                break;
            case 'qty':
                $item->qty = $this->request->getPost('lengths');
                break;
            case 'priceUnit':
                $item->priceUnit = $this->request->getPost('lengths');
                break;
            case 'unitPrice':
                $item->unitPrice = $this->request->getPost('lengths');
                break;
        }

        $response = new \Phalcon\Http\Response();
        if ($item->save()) {
            $response->setStatusCode(200, "Update successful");
        } else {
            $response->setStatusCode(500, "Something went wrong");
        }
        $response->send();
    }

    public function deleteItemAction($id)
    {
        // Disable the view and redirect anyone visiting this page incorrectly
        $this->view->disable();
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        // Find the quote item based on the id in the url
        $item = QuoteItems::findFirstById($id);

        // If the item does not exist
        if (!$item) {
            $this->flashSession->warning('Hmmm.. That item couldn\'t be found');
            $this->_redirectBack();
        }

        // Try to delete the item,
        // Flash the outcome to the session and redirect back
        if ($item->delete()) {
            $this->flashSession->success('Item was successfully deleted');
            $this->_redirectBack();
        } else {
            $this->flashSession->warning('Something went wrong and this item could not be deleted');
            $this->_redirectBack();
        }
    }

    public function saveitemsAction()
    {
        $this->view->disable();

        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        $data = $this->request->getPost();

        echo "<pre>";
        echo print_r($data);
        echo "</pre>";


        // Let's sort through the posted array and update or save data
        // Count the grade and loop through 1 less than the count
        // This is done because the last line will always contain empty values due to the JS and form setup
        $values = [];
        for ($i = 0; $i < count($data['grade']) - 1; $i ++) {
            $line = new QuoteItems();

            if (!empty($data['id'][$i])) {
                if (!in_array($data['id'][$i], $values)) {
                    array_push($values, $data['id'][$i]);
                    $line = QuoteItems::findFirstById($data['id'][$i]);
                }
            }

            $line->quoteId			= $data['quoteId'];
            $line->grade			= $data['grade'][$i];
            $line->treatment		= $data['treatment'][$i];
            $line->dryness			= $data['dryness'][$i];
            $line->finish			= $data['finish'][$i];
            $line->width			= $data['width'][$i];
            $line->thickness		= $data['thickness'][$i];
            $line->lengths			= $data['lengths'][$i];
            $line->qty				= $data['qty'][$i];
            $line->price			= $data['unitPrice'][$i];
            $line->priceMethod		= $data['priceMethod'][$i];

            $success = $line->save();

            if (!$success) {
                $this->flashSession->error('Sorry, the item could not be added');
                foreach ($item->getMessages() as $message) {
                    $this->flashSession->error($message->getMessage());
                }
            }
        }

        $this->_redirectBack();
    }
}
