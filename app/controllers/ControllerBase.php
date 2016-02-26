<?php
namespace App\Controllers;

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;

/**
 * ControllerBase
 * This is the base controller for all controllers in the application
 */
class ControllerBase extends Controller
{

    /**
     * Execute before the router so we can determine if this is a provate controller, and must be authenticated, or a
     * public controller that is open to all.
     *
     * @param Dispatcher $dispatcher
     * @return boolean
     */

    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        $this->view->setVar('logged_in', is_array($this->auth->getIdentity()));

        $controllerName = $dispatcher->getControllerName();

        // Only check permissions on private controllers
        if ($this->acl->isPrivate($controllerName)) {

            // Get the current identity
            $identity = $this->auth->getIdentity();

            // If there is no identity available the user is redirected to index/index
            if (!is_array($identity)) {

                $this->flashSession->notice('You don\'t have access to this module: ' . ucwords($controllerName));

                $this->response->redirect('login');
                
                return false;
            }
        }
    }

    public function initialize()
    {
        $this->view->setVar('logged_in', is_array($this->auth->getIdentity()));
        $this->tag->appendTitle(' | ' . SITE_TITLE);
    }
    
    protected function _redirectBack() {
        return $this->response->redirect($this->request->getServer('HTTP_REFERER'));
    }
    
}