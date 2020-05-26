<?php

namespace App\Controllers;

use App\Forms\UsersForm;
use App\Plugins\Auth\Auth;
use App\Models\Users;

class PreferencesController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Preferences');
        $this->view->pageTitle = "Preferences";

        $auth = new Auth;
        $user = Users::findFirstByid($auth->getId());
        $this->view->user = $user;

        $form = new UsersForm($user);
        $this->view->form = $form;

        if ($this->request->isPost()) {
            $this->view->disable();

            // Check the password
            if (!$this->security->checkHash($this->request->getPost('currentPass'), $user->password)) {
                $this->flashSession->error('Incorrect password');
                $this->_redirectBack();
            } else {
                if ($form->isValid($this->request->getPost()) != false) {
                    $user->assign(array(
                        'name' => $this->request->getPost('name', 'striptags'),
                        'email' => $this->request->getPost('email'),
                        'position' => $this->request->getPost('position', 'striptags'),
                        'directDial' => $this->request->getPost('directDial', 'striptags'),
                    ));

                    if (null !== $this->request->getPost('useUCA')) {
                        $user->useUCA = 1;
                    } else {
                        $user->useUCA = 0;
                    }

                    if (!empty($this->request->getPost('newpw')) and $this->request->getPost('newpw2') === $this->request->getPost('newpw')) {
                        $user->password = $this->security->hash($this->request->getPost('newpw'));
                        $user->mustChangePassword = 0;
                    }

                    if ($user->save()) {
                        $this->flashSession->success('Your details have been updated');
                        $this->_redirectBack();
                    } else {
                        $this->flashSession->error($user->getMessages());
                        $this->_redirectBack();
                    }
                } else {
                    $this->flashSession->error($user->getMessages());
                    $this->_redirectBack();
                }
            }
        }
    }
}
