<?php
namespace App\Controllers;

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

            // Log user in if remember cookie is set
            if (!is_array($this->auth->getIdentity())) {
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
        if ($this->session->get('auth-identity')['dev'] || $this->request->hasQuery("facelift")) {
            ini_set('display_errors', 1);
            ini_set('display_startup_errors', 1);
            error_reporting(E_ALL);

        }

		$this->view->elements = $this->elements;

        $this->view->setVar('logged_in', is_array($this->auth->getIdentity()));
        $this->tag->appendTitle(' | ' . SITE_TITLE);
        $this->assets->collection('header')
            ->addCss('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css', false)
            ->addCss('https://cdnjs.cloudflare.com/ajax/libs/bootflat/2.0.4/css/bootflat.min.css', false)
            ->addCss('//cdn.datatables.net/1.10.10/css/dataTables.bootstrap.min.css', false)
            ->addCss('css/app.css?v=1.21', true)
            ->addCss('css/font-awesome/css/font-awesome.min.css', true)
            ->addCss('//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css', false)
            ->addCss('//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css', false)
            ->addCss('//cdn.datatables.net/plug-ins/1.10.11/integration/font-awesome/dataTables.fontAwesome.css', false)
            ->addCss('//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css', false);

        $this->assets->collection('jquery')
            ->addJs('js/jquery-1.11.1.min.js', true);
        // JS for footer
        $this->assets->collection('footer')
            // Bootstrap Core JS
            ->addJs('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js', false)
            // Bootstrap Select 2
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js', false)
            // Custom JS
            ->addJs('js/app.js', true)
            ->addJs('//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js', false);

        // If the user has opted to use Mitel UCA phone links then load JS to convert these links on desktop
        // if ($this->session->get('auth-identity')['uca'] == 1) {
        // $this->assets->collection('footer')
        // UCA Telephone conversion
        // ->addJs('js/useUCA.js', true);
        // }

        // Add markdown support
        $this->view->parser = new \cebe\markdown\Markdown();
    }

    protected function _redirectBack()
    {
        return $this->response->redirect($this->request->getServer('HTTP_REFERER'));
    }
}
