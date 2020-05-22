<?php

namespace App\Controllers;

use App\Models\HotlistQuotes;
use App\Models\HotlistCategories;
use App\Models\HotlistFollowing;
use App\Models\HotlistTypes;
use App\Models\Quotes;
use App\Forms\HotlistForm;
use App\Models\Users;
use Phalcon\Http\Response;

class HotlistController extends ControllerBase
{
    public function initialize()
    {
        // Set the default view
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        if ($this->request->isPost()) {
            $response = new Response();
            return $response->redirect("hotlist");
        }

        $this->tag->prependTitle('Hotlist');
        $sum = number_format(HotlistQuotes::sum(array(
            "column"        => "value",
            "conditions"    => "completed IS NULL",
        )));
        $count = HotlistQuotes::count(array(
            "column"        => "value",
            "conditions"    => "completed IS NULL",
        ));
        $this->view->pageSubtitle = "<span id='tcount'></span> Projects, <span id='tsum'></span>";
        $categories = new HotlistCategories();
        $types = new HotlistTypes();
        $this->view->categories = $categories->find(array("conditions" => "system is null"));
        $this->view->types = $types->find();
        $this->view->cancel = false;

        $this->view->newForm = new HotlistForm();
        $this->view->users = Users::getActive();
        $this->view->initials = $this->elements->initials($this->auth->getName());
        $this->view->id = $this->auth->getId();
        $this->view->name = $this->auth->getName();

        $hot = new Quotes;
        $this->view->hot = $hot->getByStatus(1);

        $this->view->headerButton = '
        <div class="btn-group pull-right">
            <a class="btn btn-primary" data-toggle="modal" href="#add" role="button"><i class="fa fa-plus"></i> Add Job</a>
        </div>';

        $this->assets->collection("footer")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/Sortable/1.4.2/Sortable.min.js")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/hideseek/0.7.1/jquery.hideseek.min.js")
            ->addJs('js/to-markdown.js', true)
            ->addJs('js/bootstrap-markdown.js', true);
    }

    public function listAction()
    {
        if ($this->request->isPost()) {
            $response = new Response();
            return $response->redirect("hotlist");
        }
        $this->tag->prependTitle('Hotlist');
        $sum = number_format(HotlistQuotes::sum(array(
            "column"        => "value",
            "conditions"    => "completed IS NULL",
        )));
        $count = HotlistQuotes::count(array(
            "column"        => "value",
            "conditions"    => "completed IS NULL",
        ));
        $this->view->pageSubtitle = "$count projects, $$sum";
        $categories = new HotlistCategories();
        $types = new HotlistTypes();
        $this->view->categories = $categories->find(array("conditions" => "system is null"));
        $this->view->types = $types->find();
        $this->view->cancel = false;

        $this->view->newForm = new HotlistForm();
        $this->view->users = Users::find();
        $this->view->initials = $this->elements->initials($this->auth->getName());
        $this->view->id = $this->auth->getId();
        $this->view->name = $this->auth->getName();

        $this->view->headerButton = '
        <div class="btn-group pull-right">
            <a class="btn btn-primary" data-toggle="modal" href="#add" role="button"><i class="fa fa-plus"></i> Add Job</a>
        </div>';

        $this->assets->collection("footer")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/Sortable/1.4.2/Sortable.min.js")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/hideseek/0.7.1/jquery.hideseek.min.js")
            ->addJs('js/to-markdown.js', true)
            ->addJs('js/bootstrap-markdown.js', true);
    }

    public function newAction($customerCode = null)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $this->view->pageTitle = "Add a Lead";
    }

    public function createAction()
    {
        // if (!$this->request->isPost()){
        //     return $this->_redirectBack();
        // }

        $quote = new HotlistQuotes;
        $quote->user = $this->auth->getId();
        if ($quote->create($this->request->getPost()) === false) {
            $messages = $quote->getMessages();

            foreach ($messages as $message) {
                echo $message, "\n";
            }
        } else {
            return $this->response->redirect('hotlist');
        }
    }

    public function viewAction($quote)
    {
        $quote = HotlistQuotes::findFirstById($quote);
        $this->view->setTemplateBefore('modal-form');
        $this->view->pageTitle = '
        <a href="#" class="xedit" id="title" data-type="text" data-placement="bottom" data-pk="'. $quote->id .'"" data-url="/hotlist/update" data-title="Job Title">'. $quote->title .'</a>
        ';
        $this->view->quote = $quote;
        $this->view->form = new HotlistForm($quote);
        $this->view->types = HotlistTypes::find();
        $this->view->categories = HotlistCategories::find(["conditions" => "system IS NULL"]);
    }

    public function updatestatusAction()
    {
        $this->view->disable();

        if (!$this->request->isAjax()) {
            return $this->_redirectBack();
        }

        $response = new Response;

        $quote = HotlistQuotes::findFirstById($this->request->getPost('quote'));
        if ($quote) {
            $quote->category = $this->request->getPost('status');
            if ($quote->save()) {
                $response->setStatusCode(200, "OK");
            } else {
                $response->setStatusCode(501, "Something went wrong");
            }
        } else {
            $response->setStatusCode(404, "Quote Not Found");
        }
        return $response;
    }

    public function wonAction()
    {
        $this->view->disable();

        if (!$this->request->isAjax()) {
            return $this->_redirectBack();
        }

        $response = new Response;

        $quote = HotlistQuotes::findFirstById($this->request->getPost('quote'));
        if ($quote) {
            $quote->completed = date('Y-m-d H:i:s');
            $quote->won = 1;
            if ($quote->save()) {
                $response->setStatusCode(200, "OK");
            } else {
                $response->setStatusCode(501, "Something went wrong");
            }
        } else {
            $response->setStatusCode(404, "Quote Not Found");
        }
        return $response;
    }

    public function lostAction()
    {
        $this->view->disable();

        if (!$this->request->isAjax()) {
            return $this->_redirectBack();
        }

        $response = new Response;

        $quote = HotlistQuotes::findFirstById($this->request->getPost('quote'));
        if ($quote) {
            $quote->completed = date('Y-m-d H:i:s');
            $quote->won = 0;
            if ($quote->save()) {
                $response->setStatusCode(200, "OK");
            } else {
                $response->setStatusCode(501, "Something went wrong");
            }
        } else {
            $response->setStatusCode(404, "Quote Not Found");
        }
        return $response;
    }

    public function followAction()
    {
        $this->view->disable();

        if (!$this->request->isAjax()) {
            return $this->_redirectBack();
        }

        $response = new Response;

        $follow = new HotlistFollowing;
        $follow->id = $this->request->getPost('quote');
        $follow->user = $this->auth->getId();
        if ($follow->save()) {
            $response->setStatusCode(200, "OK");
        } else {
            $response->setStatusCode(501, "Something went wrong");
        }
        return $response;
    }

    public function updateAction()
    {
        if (!$this->request->isAjax()) {
            return $this->_redirectBack();
        }

        $response = new Response();

        $id = $this->request->getPost('pk');
        $job = HotlistQuotes::findFirstById($id);
        if (!$job) {
            $response->setStatusCode(404, "Job not found");
        } else {
            $value = $this->request->getPost('value');
            switch ($this->request->getPost('name')) {
                case 'category':
                    $job->category = $value;
                    break;
                case 'type':
                    $job->type = $value;
                    break;
                case 'value':
                    $job->value = preg_replace('~\D~', '', $value);
                    break;
                case 'description':
                    $job->description = $value;
                    break;
                case 'title':
                    $job->title = $value;
                    break;
                case 'customer':
                    $job->customer = $value;
                    break;
                case 'user':
                    $job->user = $value;
                    break;
                default:
                    $response->setStatusCode(400, "Field not found!");
                    return $response;
                    break;
            }
            if ($job->update()) {
                $response->setStatusCode(200, "Successfully Updated");
            } else {
                $response->setStatusCode(400, "Something went wrong!");
                $content = "";
                foreach ($job->messages as $message) {
                    $content .= $message;
                }
                $response->setContent("$content");
            }
        }
        return $response;
    }
}
