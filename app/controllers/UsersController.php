<?php

namespace App\Controllers;

use App\Models\Users;
use App\Forms\UsersForm;

class UsersController extends ControllerBase
{
    public function initialize()
    {
        if ($this->session->get('auth-identity')['profile'] != 1) {
            $this->flashSession->error("You don't have permission for the Users module");
            return $this->response->redirect('dashboard');
        }
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Users');
        $this->view->users = Users::find([
            'order' =>  'banned ASC, suspended ASC',
        ]);
    }

    public function editAction($userId)
    {
        $user = Users::findFirstByid($userId);
        $form = new UsersForm($user);

        $this->view->form = $form;
        $this->view->user = $user;

        $this->tag->prependTitle('Editing '. $user->name);

        if (!$user) {
            $this->flashSession->error("That user could not be found");
            $this->_redirectBack();
        }

        $form = new UsersForm();
    }

    public function updateAction()
    {
        if (!$this->request->isPost()) {
            $this->flashSession->error("You shouldn't be there.");
            $this->_redirectBack();
        }

        $user = Users::findFirstByid($this->request->getPost('id'));
        $user->name = $this->request->getPost('name');
        $user->email = $this->request->getPost('email');
        $user->position = $this->request->getPost('position');
        if ($this->request->getPost('developer')) {
            $user->dev = 1;
        } else {
            $user->dev = 0;
        }
        if ($this->request->getPost('banned')) {
            $user->banned = 1;
        } else {
            $user->banned = 0;
        }
        if ($this->request->getPost('admin')) {
            $user->profilesId = 1;
        } else {
            $user->profilesId = 2;
        }
        if ($this->request->getPost('suspended')) {
            $user->suspended = 1;
        } else {
            $user->suspended = 0;
        }
        if ($this->request->getPost('banned')) {
            $user->banned = 1;
        } else {
            $user->banned = 0;
        }

        if ($this->request->hasPost("newpw")) {
            if ($this->request->getPost("newpw") == $this->request->getPost("newpw2")) {
                $user->password = $this->security->hash($this->request->getPost('newpw'));
            }
        }

        $user->save();

        $this->flashSession->success("User successfully updated");
        $this->_redirectBack();
    }

    public function activateAction($userId)
    {
        $this->view->disable();

        $user = Users::findFirstByid($userId);
        $user->active = 1;
        $user->update();
        $this->flashSession->success("User <strong>" . $user->name . "</strong> has been successfully activated");
        $this->_redirectBack();
    }

    public function deleteAction($userId)
    {
        $user = Users::findFirstByid($userId);
        if (!$user) {
            $this->flashSession->error('That user does not exist');
            return $this->response->redirect('users');
        }
        if (count($user->history) > 0) {
            $this->flashSession->error('This user has records associated to them and cannot be deleted.');
            return $this->response->redirect('users');
        }
        $this->flashSession->success("This isn't fully implemented yet");
        return $this->response->redirect('users');
    }
}
