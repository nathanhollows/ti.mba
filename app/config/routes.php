<?php

$router = new Phalcon\Mvc\Router(false);

$router->setDefaultNamespace('App\Controllers');

// Define default routes. File gets included in services.php

$router->add('/', array(
	'controller' => 1
));

$router->add('/:controller/:action/:params', array(
	'controller' => 1,
	'action' => 2,
	'params' => 3,
));

$router->add('/:controller', array(
	'namespace' => 'App\Controllers',
	'controller' => 1
));

// Auth controllers

$router->add('/login', array(
	'controller' => 'session',
	'action'	=>	'login'
));

$router->add('/logout', array(
	'controller' => 'session',
	'action'	=>	'logout'
));

$router->add('/register', array(
	'controller' => 'session',
	'action'	=>	'register'
));

$router->add('/forgotpassword', array(
	'controller' => 'session',
	'action'	=>	'forgotpassword'
));

// Quotes router

$router->add('/quote/:params', array(
	'controller' => 'quotes',
	'action'	=>	'public',
	'params'	=> 1
));

// KPI router

$router->add(
	"/kpi/([0-9]{4})/([0-9]{2})/([0-9]{2})/:params",
	array(
		"controller"	=> "kpi",
		"action"		=> "edit",
		"year"			=> 1, // ([0-9]{4})
		"month"			=> 2, // ([0-9]{2})
		"day"			=> 3, // ([0-9]{2})
		"params"		=> 4 // :params
));

// 404 Controller

$router->notFound(
  array(
    'controller' => 'error',
    'action' => 'show404'
  )
);

// Remove trailing slahes automatically
$router->removeExtraSlashes(true);

return $router;