<?php

namespace App\Controllers;

use Phalcon\Tag;

use App\Forms\LoginForm;
use App\Forms\SignUpForm;
use App\Forms\ForgotPasswordForm;
use App\Plugins\Auth\Exception as AuthException;
use App\Models\Users;
use App\Models\ResetPasswords;

class SessionController extends ControllerBase
{
    
    public function initialize()
    {
        parent::initialize();
        $this->view->setTemplateBefore('auth');
        $this->view->setViewsDir('/var/www/html/app/facelift/');
    }
    
    public function indexAction()
    {
    }
    
    /**
    * Starts a session in the admin backend
    */
    public function loginAction()
    {
        // Create a default user
        $users = Users::find();
        if (count($users) == 0) {
            $user = new Users();
            $user->name = 'Administrator';
            $user->email = 'admin@ti.mba';
            $user->password = $this->security->hash('password');
            $user->active = 1;
            $user->suspended = 0;
            $user->developer = 1;
            $user->administrator = 1;
            if ($user->save() == false) {
                foreach ($user->getMessages() as $message) {
                    $this->flash->error($message);
                }
            } else {
                $this->flash->notice("Default user created with email: admin@ti.mba and password: password");
            }
        }
        
        
        if ($this->session->has('auth-identity')) {
            return $this->response->redirect('dashboard');
        }
        
        $this->view->setTemplateBefore('auth');
        
        $this->tag->prependTitle('Login');
        
        $form = new LoginForm();
        
        try {
            if (!$this->request->isPost()) {
                if ($this->auth->hasRememberMe()) {
                    return $this->auth->loginWithRememberMe();
                }
            } else {
                if (!$form->isValid($this->request->getPost())) {
                    foreach ($form->getMessages() as $message) {
                        $this->flash->error($message);
                    }
                } else {
                    $this->auth->check(array(
                        'email' => $this->request->getPost('email'),
                        'password' => $this->request->getPost('password')
                    ));
                    
                    return $this->response->redirect('dashboard');
                }
            }
        } catch (AuthException $e) {
            $this->flash->error($e->getMessage());
        }
        
        $this->view->form = $form;
    }
    
    /**
    * Shows the forgot password form
    */
    public function forgotPasswordAction()
    {
        $this->tag->prependTitle('Forgotton Password');
        
        $form = new ForgotPasswordForm();
        $this->view->form = $form;
        
        // If the user has submitted their email address
        if ($this->request->isPost()) {
            if ($form->isValid($this->request->getPost()) == false) {
                foreach ($form->getMessages() as $message) {
                    $this->flash->error($message);
                }
            } else {
                $user = Users::findFirstByemail($this->request->getPost('Email'));
                if (!$user) {
                    $this->flash->success('There is no account associated to this email');
                } else {
                    $resetPassword = new ResetPasswords();
                    $resetPassword->usersId = $user->id;
                    if ($resetPassword->save()) {
                        $this->flash->success('Success! Please check your messages for an email reset password');
                    } else {
                        foreach ($resetPassword->getMessages() as $message) {
                            $this->flash->error($message);
                        }
                    }
                }
            }
        }
    }
    
    public function resetpasswordAction($token = null)
    {
        $this->tag->prependTitle('Reset Password');
        
        $this->view->token = false;
        
        if (!$token) {
            $this->flash->error('Link is invalid');
            return true;
        }
        
        $reset = ResetPasswords::findFirstBycode($token);
        
        if (!$reset) {
            $this->flash->error('Token is invalid or has expired');
            return true;
        }
        
        $this->view->token = true;
    }
    
    private function updatepassword()
    {
    }
    
    /**
    * Closes the session
    */
    public function logoutAction()
    {
        $this->auth->remove();
        return $this->response->redirect('login');
    }
}
