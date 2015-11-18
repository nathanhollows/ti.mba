<?php

namespace App\Controllers\Admin;

use Phalcon\Mvc\Controller,
	Phalcon\Tag;

class ControllerBase extends Controller
{
    /**
     * Execute before the router so we can determine if this is a provate controller, and must be authenticated, or a
     * public controller that is open to all.
     *
     * @param Dispatcher $di
     * @return boolean
     */

    public function beforeExecuteRoute($di)
    {

        $this->view->setVar('logged_in', is_array($this->auth->getIdentity()));

        $controllerName = $di->getControllerName();
        // Only check permissions on private controllers
        if ($this->acl->isPrivate($controllerName)) {
            // Get the current identity
            $identity = $this->auth->getIdentity();
            // If there is no identity available the user is redirected to index/index
            if (!is_array($identity)) {
                $this->flash->notice('You don\'t have access to this module: private');
                $di->forward(array(
                    'controller' => 'index',
                    'action' => 'index'
                ));
                return false;
            }
            // Check if the user have permission to the current option
            $actionName = $di->getActionName();
            if (!$this->acl->isAllowed($identity['profile'], $controllerName, $actionName)) {
                $this->flash->notice('You don\'t have access to this module: ' . $controllerName . ':' . $actionName);
                if ($this->acl->isAllowed($identity['profile'], $controllerName, 'index')) {
                    $di->forward(array(
                        'controller' => $controllerName,
                        'action' => 'index'
                    ));
                } else {
                    $di->forward(array(
                        'controller' => 'user_control',
                        'action' => 'index'
                    ));
                }
                return false;
            }
        }
    }

	protected function initialize()
	{
		Tag::appendTitle(' | ' . SITE_TITLE);
        $this->view->setVar('logged_in', is_array($this->auth->getidentity()));
        $this->view->setViewsDir($this->view->getViewsDir() . 'admin/');

	}

	public function afterExecuteRoute()
	{
        
	}
}