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
        // Globally used CSS
        $this->assets->collection('header')
            ->addCss('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css')
            ->addCss('https://cdnjs.cloudflare.com/ajax/libs/bootflat/2.0.4/css/bootflat.min.css')
            ->addCss('//cdn.datatables.net/1.10.10/css/dataTables.bootstrap.min.css')
            ->addCss('css/bootstrap-markdown.min.css')
            ->addCss('css/app.css')
            ->addCss('https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css')
            ->addCss('//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css')
            ->addCss('//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css')
            ->addCss('//cdn.datatables.net/plug-ins/1.10.11/integration/font-awesome/dataTables.fontAwesome.css');
        // Globally used JQuery
        $this->assets->collection('jquery')
            ->addJs('//code.jquery.com/jquery-1.11.1.min.js');
        // JS for footer
        $this->assets->collection('footer')
            // Bootstrap Core JS
            ->addJs('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js')
            // In-Browser Markdown Parser for live editing
            ->addJs('js/to-markdown.js')
            ->addJs('js/bootstrap-markdown.js')
            ->addJs('js/markdown.js')
            // DataTables
            ->addJs('//cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js')
            ->addJs('//cdn.datatables.net/1.10.10/js/dataTables.bootstrap.min.js')
            // Bootstrap Select 2
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js')
            // Custom JS
            ->addJs('js/app.js');
    }
    
    protected function _redirectBack() {
        return $this->response->redirect($this->request->getServer('HTTP_REFERER'));
    }
    
}