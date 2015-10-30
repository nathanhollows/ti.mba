<?php

$router = new Phalcon\Mvc\Router(false);

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

$router->add('/login', array(
	'namespace' => 'App\Controllers\Auth',
	'controller' => 'index',
	'action'	=>	'login'
));


// Remove trailing slahes automatically
$router->removeExtraSlashes(true);

// Set 404 paths
$router->notFound(
    array(
    	"namespace"	 => "App\Controllers",
        "controller" => "error",
        "action"     => "show404"
    )
);

return $router;