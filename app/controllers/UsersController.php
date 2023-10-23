<?php

namespace App\Controllers;

use App\Models\Users;
use App\Forms\UsersForm;

class UsersController extends ControllerBase
{
    public function initialize()
    {
        if ($this->auth->getUser()->administrator != 1) {
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
            'order' =>  'suspended ASC',
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
        $user->directDial = $this->request->getPost('directDial');
        $user->position = $this->request->getPost('position');
        if ($this->request->getPost('developer')) {
            $user->developer = 1;
        } else {
            $user->developer = 0;
        }
        if ($this->request->getPost('suspended')) {
            $user->suspended = 1;
        } else {
            $user->suspended = 0;
        }
        if ($this->request->getPost('admin')) {
            $user->administrator = 1;
        } else {
            $user->administrator = 0;
        }
        
        if ($this->request->hasPost("newpw") && $this->request->getPost("newpw") != "") {
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
    
    public function newAction()
    {
        $this->tag->prependTitle('Add a User');
        $form = new UsersForm();
        $this->view->form = $form;
        
        if ($this->request->isPost()) {
            $user = new Users();
            $user->name = $this->request->getPost('name');
            $user->email = $this->request->getPost('email');
            $user->directDial = $this->request->getPost('directDial');
            $user->position = $this->request->getPost('position');
            if ($this->request->getPost('developer')) {
                $user->developer = 1;
            } else {
                $user->developer = 0;
            }
            if ($this->request->getPost('suspended')) {
                $user->suspended = 1;
            } else {
                $user->suspended = 0;
            }
            if ($this->request->getPost('admin')) {
                $user->administrator = 1;
            } else {
                $user->administrator = 0;
            }
            // Check newpw and newpw2 match
            if ($this->request->getPost('newpw') != $this->request->getPost('newpw2')) {
                $this->flashSession->error("Passwords do not match");
                $this->_redirectBack();
                return;
            }
            $user->password = $this->security->hash($this->request->getPost('newpw'));
            $user->active = 1;
            
            if (!$user->save()) {
                foreach ($user->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                $this->_redirectBack();
            }
            
            $this->flashSession->success("User successfully created");
            // Direct to the edit page for the new user
            $this->response->redirect('users/edit/' . $user->id);
        }
    }
}
