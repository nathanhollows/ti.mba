<?php
namespace App\Controllers\Mobile;

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
use App\Plugins\Auth;

/**
 * ControllerBase
 * This is the base controller for all controllers in the application
 */
class ControllerBase extends Controller
{

    /**
     * Execute before the router so we can determine if this is a private controller, and must be authenticated, or a
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
                if ($this->auth->hasRememberMe()) {
                    $this->auth->loginWithRememberMe($noRedirect = true);
                } else {
                    return $this->response->redirect('logout');
                }
            }
        }
    }

    public function initialize()
    {
        $this->view->setVar('logged_in', is_array($this->auth->getIdentity()));
        $this->tag->appendTitle(' | ' . SITE_TITLE);

        // Set up resources
        $this->assets->collection('header')
            ->addCss('https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css', false);
        $this->assets->collection('jquery')
            ->addJs('https://code.jquery.com/jquery-3.2.1.min.js', true);
        $this->assets->collection('footer')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js', false)
            ->addJs('https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js', false);
    }

    /**
     * afterExecuteRoute
     * Set view directory
     */
    public function afterExecuteRoute()
    {
        $this->view->setViewsDir($this->view->getViewsDir() . 'mobile/');
    }

    protected function _redirectBack()
    {
        return $this->response->redirect($this->request->getServer('HTTP_REFERER'));
    }
}
