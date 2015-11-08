<?php

$router = new Phalcon\Mvc\Router(false);

// Define defaukt routes. File gets included in services.php

$router->add('/', array(
	'namespace' => 'App\Controllers',
	'controller' => 1
));

$router->add('/:controller/:action/:params', array(
	'namespace' => 'App\Controllers',
	'controller' => 1,
	'action' => 2,
	'params' => 3,
));

$router->add('/:controller', array(
	'namespace' => 'App\Controllers',
	'controller' => 1
));

$router->add('/admin/:controller/:action/:params', array(
	'namespace' => 'App\Controllers\Admin',
	'controller' => 1,
	'action' => 2,
	'params' => 3,
));

$router->add('/admin/:controller', array(
	'namespace' => 'App\Controllers\Admin',
	'controller' => 1
));

$router->add('/admin', array(
	'namespace' => 'App\Controllers\Admin',
	'controller' => 'index',
	'action'	=>	'index'
));

// Auth controllers

$router->add('/login', array(
	'namespace' => 'App\Controllers',
	'controller' => 'session',
	'action'	=>	'login'
));

$router->add('/signup', array(
	'namespace' => 'App\Controllers',
	'controller' => 'session',
	'action'	=>	'signup'
));

$router->add('/forgotpassword', array(
	'namespace' => 'App\Controllers',
	'controller' => 'session',
	'action'	=>	'forgotpassword'
));

// Remove trailing slahes automatically
$router->removeExtraSlashes(true);

return $router;