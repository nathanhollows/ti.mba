<?php

namespace App\Controllers;

use App\Auth\Auth;
use App\Models\ContactRecord;
use App\Models\Users;

class TasksController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction($userId = null)
    {
        $auth = new Auth;
        $user = $auth->getId();
        $this->view->id = $user;

        if (isset($userId)) {
            $user = $userId;
        }

        $this->tag->prependTitle('Tasks');
        $this->view->noHeader = true;

        $this->view->parser = new \cebe\markdown\Markdown();

        $this->assets->collection('footer')
            // DataTables
            ->addJs('//cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js', false)
            ->addJs('//cdn.datatables.net/1.10.10/js/dataTables.bootstrap.min.js', false);

        // Fetch today's current tasks belonging to the logged in user
        $data = new ContactRecord;

        $this->view->overdue	= $data->getOverdue($user);
        $this->view->today		= $data->getToday($user);
        $this->view->coming 	= $data->getComing($user);


        $this->view->dates = ContactRecord::find(array(
            'columns'		=> 'followUpDate',
            'conditions'	=> 'user = ?1 AND completed IS NULL',
            'bind'			=> array(1 => $user),
        ));

        $this->view->users = Users::getActive();
    }

    public function userAction($userId = null)
    {
        $auth = new Auth;
        $user = $auth->getId();

        if (!is_null($userId)) {
            $user = $userId;
        }
        $this->view->id = $user;

        $this->tag->prependTitle('Tasks');

        $this->view->parser = new \cebe\markdown\Markdown();

        $this->assets->collection('footer')
            // DataTables
            ->addJs('//cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js', false)
            ->addJs('//cdn.datatables.net/1.10.10/js/dataTables.bootstrap.min.js', false);

        $data= new ContactRecord;

        $this->view->overdue	= $data->getOverdue($user);
        $this->view->today		= $data->getToday($user);
        $this->view->coming 	= $data->getComing($user);

        $this->view->users = Users::getActive();

        $this->view->noHeader = true;
        $this->view->pick('tasks/index');
    }

    public function viewAction($id = null)
    {
        if (!$this->request->isAjax()) {
            $this->flashSession->error('Woops, something went wrong.');
            return $this->_redirectBack();
        }

        if (is_null($id)) {
            $this->flashSession->error('No record was entered');
        }

        $this->view->setTemplateBefore('none');

        $this->view->record = ContactRecord::findFirstById($id);
    }

    public function listAction($userId = null)
    {
        $auth = new Auth;
        $user = $auth->getId();

        if (!is_null($userId)) {
            $user = $userId;
        }
        $this->view->id = $user;

        $this->tag->prependTitle('Tasks');

        $this->view->parser = new \cebe\markdown\Markdown();

        // Fetch today's current tasks belonging to the logged in user
        $data = new ContactRecord;

        $this->view->overdue	= $data->getOverdue($user);
        $this->view->today		= $data->getToday($user);
        $this->view->coming 	= $data->getComing($user);

        $this->view->users = Users::find();
    }
}
