<?php

use Phalcon\Mvc\User\Component;

/**
 * Elements
 *
 * Helps to build UI elements for the application
 */
class Elements extends Component
{

    private $_privateMenu = array(
        'navbar-left' => array(
            'dashboard' => array(
                'caption' => 'Dashboard',
                'action' => ''
                ),
            'customers' => array(
                'caption' => 'Companies',
                'action' => '',
                ),
            'contacts' => array(
                'caption' => 'Contacts',
                'action' => '',
                ),
            'quotes' => array(
                'caption' => 'Quotes',
                'action' => '',
                ),
            'tasks' => array(
                'caption' => 'Tasks',
                'action' => '',
                ),
            ),
        'navbar-right' => array(
            'messages' => array(
                'caption' => '<span><i class="fa fa-envelope"></i></span>&nbsp;',
                'action' => ''
                ),
            'tasks' => array(
                'caption' => '<span><i class="fa fa-bell"></i></span>&nbsp;',
                'action' => ''
                ),
            '' => array(
                'caption' => 'User',
                'action' => '',
                                'children'  => array(
                    array('Profile', 'profile'),
                    array('Logout', 'logout'),
                    )
                ),
            )
        );

    private $_publicMenu = array(
        'Home' => array(
            'controller' => 'index',
            'action' => '',
            'any' => true
            ),
        'About' => array(
            'controller' => 'about',
            'action' => '',
            'any' => true
            ),
        'Contact' => array(
            'controller' => 'contact',
            'action' => 'index',
            'any' => true
            ),
        );

    /**
     * Builds header menu with left and right items
     *
     * @return string
     */
    public function getPrivateMenu()
    {

        $controllerName = $this->view->getControllerName();
        foreach ($this->_privateMenu as $position => $menu) {
            echo '<ul class="nav navbar-nav ', $position, '">';
            foreach ($menu as $controller => $option) {
                if ($controllerName == $controller && isset($option['children'])) {
                    echo '<li class="active dropdown">';
                } elseif ($controllerName == $controller) {
                    echo '<li class="active">';
                } else {
                    echo '<li>';
                }
                if (isset($option['children'])) {
                    echo $this->tag->linkTo(array($controller . '/' . $option['action'], $option['caption'] . "<span class='caret'></span>", "class" => "dropdown-toggle", "data-toggle" => "dropdown", "role" => "button", "aria-haspopup" => "true", "aria-expanded" => "false"));
                    echo '<ul class="dropdown-menu">';
                    foreach ($option['children'] as $key) {
                        echo "<li>";
                        echo $this->tag->linkTo($controller . '/' . $key['1'], $key[0]);
                        echo "</li>";
                    }
                    echo '</ul>';
                } else {
                    echo $this->tag->linkTo($controller . '/' . $option['action'], $option['caption']);
                }
                echo '</li>';
            }
            echo '</ul>';
        }

    }

        // <li class="dropdown">
        //   <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown </a>
        // </li>


    /**
     * Returns menu tabs
     */
    public function getPublicMenu()
    {
        $controllerName = $this->view->getControllerName();
        $actionName = $this->view->getActionName();
        echo '<div id="navbar" class="collapse navbar-collapse">';
        echo '<ul class="nav navbar-nav">';
        foreach ($this->_publicMenu as $caption => $option) {
            if ($option['controller'] == $controllerName && ($option['action'] == $actionName || $option['any'])) {
                echo '<li class="active">';
            } else {
                echo '<li>';
            }
            echo $this->tag->linkTo($option['controller'] . '/' . $option['action'], $caption), '</li>';
        }
        echo '</ul>';
        echo '<ul class="nav navbar-nav pull-right">';
        $identity = $this->auth->getIdentity();
        if (is_array($identity)) {
            echo '<li>' . $this->tag->linkTo('dashboard', 'Dashboard') . '</li>';
            echo $this->tag->linkTo(array("logout","Log out", "class" => "btn btn-default navbar-btn"));
        } else {
            echo $this->tag->linkTo(array("login","Sign In", "class" => "btn btn-default navbar-btn"));
        }
        echo '</ul>';
        echo '</div><!--/.nav-collapse -->';
    }
}