<?php

namespace App\Plugins;

use Phalcon\Di\Injectable;
use App\Models\ContactRecord;

/**
 * Elements
 *
 * Helps to build UI elements for the application
 */
class Elements extends Injectable
{
    private $_leftNav = array(
        'dashboard' => array(
            'icon'  => 'activity',
            'caption' => 'Dashboard',
            'action' => ''
        ),
        'customers' => array(
            'icon'  => 'users',
            'caption' => 'Customers',
            'action' => '',
        ),
        'quotes' => array(
            'icon'  => 'file-text',
            'caption' => 'Quotes',
            'action' => '',
            'children' => array(
                array('My Quotes', 'quotes/manage'),
                array('Search', 'quotes/'),
                array('New', 'quotes/new'),
            ),
        ),
        'orders' => array(
            'icon'  => 'box',
            'caption' => 'Orders',
            'action' => '',
            'children' => array(
                array('Orders', 'orders'),
                array('Freight Tracker', 'freight'),
                array('Committed Stock', 'stock/committed'),
            )
        ),
        'kpi' => array(
            'icon'  => 'truck',
            'caption' => 'KPI\'s',
            'action' => '',
            'children' => array(
                array('Sales', 'kpi/dailysales'),
                array('Daily KPI\'s', 'kpi/'),
            )
        ),
        'reports' => array(
            'icon'  => 'bar-chart',
            'caption' => 'Reports',
            'action' => '',
            'children' => array(
                array('Trip Planner', 'reports/tripplanner'),
                array('Annual Sales', 'reports/annual'),
                array('Regional Sales', 'reports/regions'),
            )
        ),
    );

    private $_rightNav = array(
        '' => array(
            'caption' => '<img src="/img/icons/settings.svg" style="filter: brightness(0) invert(0.7); margin: 0.2rem; width: 1.2rem;"></img>',
            'action' => '',
            'children'  => array(
                array('Profile', 'profile'),
                array('Preferences', 'preferences'),
                array('CRM Settings', 'settings'),
                array('Logout', 'logout'),
            )
        )
    );

    private $_privateMenu = array(
        'navbar-left' => array(
            'dashboard' => array(
                'icon'  => 'activity',
                'caption' => 'Dashboard',
                'action' => ''
            ),
            'customers' => array(
                'icon'  => 'users',
                'caption' => 'Companies',
                'action' => '',
            ),
            'quotes' => array(
                'icon'  => 'file-text',
                'caption' => 'Quotes',
                'action' => '',
            ),
            'orders' => array(
                'icon'  => 'box',
                'caption' => 'Orders',
                'action' => '',
                'children' => array(
                    array('Orders', 'orders'),
                    array('Freight Tracker', 'freight'),
                    array('Committed Stock', 'stock/committed'),
                )
            ),
            'kpi' => array(
                'icon'  => 'truck',
                'caption' => 'KPI\'s',
                'action' => '',
                'children' => array(
                    array('Daily KPI\'s', 'kpi/'),
                    array('Sales', 'kpi/dailysales'),
                )
            ),
            'reports' => array(
                'icon'  => 'bar-chart',
                'caption' => 'Reports',
                'action' => '',
                'children' => array(
                    array('Customers', 'reports/customers'),
                    array('Monthly Sales', 'reports/sales'),
                    array('Annual Sales', 'reports/annual'),
                )
            ),
        ),
        'navbar-right faa-parent animated-hover' => array(
            '' => array(
                'caption' => 'Account',
                'action' => '',
                'children'  => array(
                    array('Profile', 'profile'),
                    array('Preferences', 'preferences'),
                    array('CRM Settings', 'settings'),
                    array('Logout', 'logout'),
                )
            ),
        )
    );

    /**
     * Construct BS4 menu
     */
    public function getNavLeft()
    {
        $user = $this->auth->getId();
        $controllerName = $this->view->getControllerName();

        foreach ($this->_leftNav as $controller => $option) {
            $active = ($controller == $controllerName ? "active" : "");
            $class = (isset($option['class']) ? $option['class'] : "");
            if (isset($option['children'])) {
                echo "<li class='nav-item dropdown $active'>";
                echo '<a class="nav-link dropdown-toggle ' . $class . '" href="#" id="' . $controller . 'Dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
                echo $option['caption'];
                echo '</a>';

                echo '<div class="dropdown-menu" aria-labelledby="' . $controller . 'Dropdown">';
                foreach ($option['children'] as $key) {
                    $class = (isset($key['class']) ? $key['class'] : "");
                    echo $this->tag->linkTo([
                        $key['1'],
                        $key[0],
                        'class' => "dropdown-item $class",
                    ]);
                }
                echo '</div>';
                echo '</li>';
            } else {
                echo "<li class='nav-item $active'>";
                echo $this->tag->linkTo([
                    $controller . '/' . $option['action'],
                    $option['caption'],
                    'class' => "nav-link $class",
                ]);
                echo '</li>';
            }
        }
    }

    public function getNavRight()
    {
        $user = $this->auth->getId();
        $controllerName = $this->view->getControllerName();
        echo '
<ul id="search-results" class="list-group shadow d-sm-none"></ul>
<li class="nav-item">
<form id="search-form" style="height: 100%;" class="form-inline  my-2 my-lg-0" action="/search/q/" method="post" autocomplete="off">
<input type="search" id="search-nav" placeholder="Search" aria-label="Search" name="query" style="background: #ffffff17;border: none;color: white;height: 100%;display: inline-block;padding: 0 2.3em 0 0.7em;width: 14.6vw;max-width: 13em;min-width: 8.9em;">

<button type="submit" style="filter: brightness(1) invert(0.6);margin-left: -1.9em;" class="btn p-0 mr-3">
<img src="/img/icons/search.svg" style="width: 1.4rem;">
</button>
</form>
<div id="search-results"></div>
</li>';

        foreach ($this->_rightNav as $controller => $option) {
            $active = ($controller == $controllerName ? "active" : "");
            if (isset($option['children'])) {
                echo "<li class='nav-item dropdown $active'>";
                echo '<a class="nav-link dropdown-toggle" href="#" id="' . $controller . 'Dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
                echo $option['caption'];
                echo '</a>';

                echo '<div class="dropdown-menu dropdown-menu-right" aria-labelledby="' . $controller . 'Dropdown">';
                foreach ($option['children'] as $key) {
                    echo $this->tag->linkTo([
                        $key['1'],
                        $key[0],
                        'class' => 'dropdown-item'
                    ]);
                }
                echo '</div>';
                echo '</li>';
            } else {
                echo "<li class='nav-item $active'>";
                echo $this->tag->linkTo([
                    $controller . '/' . $option['action'],
                    $option['caption'],
                    'class' => 'nav-link',
                ]);
                echo '</li>';
            }
        }
    }

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
                $class = "";
                if (isset($option['children'])) {
                    $class = $class . "dropdown";
                }
                if ($controllerName == $controller) {
                    $class = $class . " active";
                }
                echo "<li class='$class'>";

                if (isset($option['children'])) {
                    echo $this->tag->linkTo(array(
                        $controller . '/' . $option['action'],
                        $option['caption'] . "<span class='caret'></span>",
                        "class" => "dropdown-toggle",
                        "data-toggle" => "dropdown",
                        "role" => "button",
                        "aria-haspopup" => "true",
                        "aria-expanded" => "false"
                    ));

                    echo '<ul class="dropdown-menu">';
                    foreach ($option['children'] as $key) {
                        echo "<li>";
                        echo $this->tag->linkTo($key['1'], $key[0]);
                        echo "</li>";
                    }
                    echo '</ul>';
                } else {
                    if (isset($option['modal'])) {
                        echo $this->tag->linkTo(array(
                            $controller . '/' . $option['action'],
                            $option['caption'],
                            'data-target'  => '#modal-ajax',
                            'role' => 'button'
                        ));
                    }
                }
                echo '</li>';
            }
            echo '</ul>';
        }
    }

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
            echo $this->tag->linkTo(array("logout", "Log out", "class" => "btn btn-default navbar-btn"));
        } else {
            echo $this->tag->linkTo(array("login", "Sign In", "class" => "btn btn-default navbar-btn"));
        }
        echo '</ul>';
        echo '</div><!--/.nav-collapse -->';
    }

    public static function initials($words)
    {
        $words = explode(" ", $words);
        $acronym = "";

        foreach ($words as $w) {
            $acronym .= $w[0];
        }
        return $acronym;
    }
}
