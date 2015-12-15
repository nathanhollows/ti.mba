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

$router->add('/signup', array(
	'controller' => 'session',
	'action'	=>	'signup'
));

$router->add('/forgotpassword', array(
	'controller' => 'session',
	'action'	=>	'forgotpassword'
));

$router->notFound(
  array(
    'controller' => 'error',
    'action' => 'show404'
  )
);

// Remove trailing slahes automatically
$router->removeExtraSlashes(true);

return $router;