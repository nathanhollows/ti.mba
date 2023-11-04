<?php

namespace App\Controllers;

use App\Models\ContactRecord;
use App\Models\Quotes;
use App\Models\Kpis;
use App\Models\SalesAreas;
use App\Models\Users;
use App\Models\DailySales;
use App\Models\Budgets;
use App\Models\StickyNotes;
use App\Models\Orders;

class DashboardController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        $this->tag->prependTitle('Dashboard');
        parent::initialize();
    }

    public function indexAction()
    {
        $tasks = new ContactRecord;
        $this->view->noHeader = true;

        $user = $this->session->get('auth-identity')['id'];

        $unassignedAreas = SalesAreas::find(array(
            'conditions'    => 'agent IS NULL',
            'cache'         => array(
                'key'       => 'unassigned-areas',
                'lifetime'  => 86400
            ),
        ));
        if (count($unassignedAreas) > 0) {
            $this->flash->notice("There are " . count($unassignedAreas) . " sales areas without an assigned rep. You can assign them <strong>" . \Phalcon\Tag::linkTo(array('settings/salesareas', 'here')) . "</strong>.");
        }

        $this->view->budget = Budgets::current();
        $this->view->kpis = Kpis::thisMonth();
        $this->view->users = Users::listUsers();
        $this->view->monthsSales = DailySales::sumMonth();
        $this->view->daySales = DailySales::sumDay(date("Y-m-d"));
        $this->view->agentSales = DailySales::getMonthByRep(date("Y-m-d"));
        $this->view->daySalesByAgent = DailySales::getDayByRep(date("Y-m-d"));
        $this->view->sales = DailySales::dailySalesBetween(date("Y-m-01"), date("Y-m-t"));

        $this->view->parser = new \cebe\markdown\Markdown();

        $this->view->quotes = new Quotes();
    }

    public function createstickyAction()
    {
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        $note = new StickyNotes();
        $note->title = $this->request->getPost('title');
        $note->note = $this->request->getPost('note');
        $note->expires = date("Y-m-d", strtotime($this->request->getPost('expires')));
        $note->type = $this->request->getPost('type');
        $success = $note->save();
        if ($success) {
            $this->response->redirect('dashboard');
            $this->view->disable;
        } else {
            $this->flash->error("Sorry, the note could not be saved");
            foreach ($note->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }

    public function deletenoteAction($id)
    {
        if (!$id) {
            $this->_redirectBack();
        }

        $note = StickyNotes::findFirstById($id);
        $success = $note->delete();
        if ($success) {
            $this->response->redirect('dashboard');
            $this->view->disable;
        } else {
            $this->flash->error("Sorry, the note could not be deleted");
            foreach ($note->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }

    public function despatchAction()
    {
        $tasks = new ContactRecord;

        $this->view->orderLocations = Orders::countLocations();

        $user = $this->session->get('auth-identity')['id'];
        $this->view->notes              = StickyNotes::current();
        $this->view->parser = new \cebe\markdown\Markdown();
    }
}
