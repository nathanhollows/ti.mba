<?php

namespace App\Controllers;

use Phalcon\Tag;

use App\Forms\LoginForm;
use App\Forms\SignUpForm;
use App\Forms\ForgotPasswordForm;
use App\Auth\Exception as AuthException;
use App\Models\Users;
use App\Models\ResetPasswords;


class SessionController extends ControllerBase
{

    /**
     * Default action. Set the public layout (layouts/public.volt)
     */
    public function initialize()
    {
        parent::initialize();
        $this->view->setTemplateBefore('auth');
    }

    public function indexAction()
    {

    }

    /**
     * Allow a user to signup to the system
     */
    public function registerAction()
    {
        // Disabled registration
        return $this->response->redirect("login");

        $this->tag->prependTitle('Register');

        $form = new SignUpForm();

        if ($this->request->isPost()) {

            if ($form->isValid($this->request->getPost()) != false) {

                $user = new Users();

                $user->assign(array(
                    'name' => $this->request->getPost('name', 'striptags'),
                    'email' => $this->request->getPost('email'),
                    'password' => $this->security->hash($this->request->getPost('password')),
                    'profilesId' => 2,
                    'banned'    => '0',
                    'suspended'    => '0',
                    'mustChangePassword'    => '0',
                    'active'    => '0',
                ));

                if ($user->save()) {
                    $this->response->redirect("login");
                    $this->view->disable();
                }

                $this->flash->error($user->getMessages());
            }
        }

        $this->view->form = $form;
    }

    /**
     * Starts a session in the admin backend
     */
    public function loginAction()
    {
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

    private function updatepassword() {

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
