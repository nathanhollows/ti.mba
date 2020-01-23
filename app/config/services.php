<?php

use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\View;
use Phalcon\Crypt;
use Phalcon\Mvc\Router;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Cache\Frontend\Data as FrontendData;
use Phalcon\Cache\Backend\Memcache as BackendMemcache;
use Phalcon\Flash\Direct as Flash;
use Phalcon\Flash\Session as FlashSession;
use Phalcon\Events\Manager as EventsManager;
use App\Mail\Mail;


use App\Auth\Auth,
	App\Acl\Acl;


/**
 * The FactoryDefault Dependency Injector automatically register the right services providing a full stack framework
 */
$di = new FactoryDefault();

// Ensure config.php has been set
if (empty($config)) {
	echo "Please create app/config/config.php. A template exists in that folder.";
	die;
}
// Store it in the Di container
$di->set('config', $config);

$di->set('router', function(){
	return require __DIR__ . '/routes.php';
}, true);

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->set('url', function() use ($config) {
	$url = new UrlResolver();
	$url->setBaseUri($config->application->baseUri);
	return $url;
}, true);

/**
 * Crypt service
 */
$di->set('crypt', function () use ($config) {
    $crypt = new Crypt();
    $crypt->setKey($config->application->cryptSalt);
    return $crypt;
});

/**
 * Flash service with custom CSS classes
 */
$di->set('flash', function () {
    return new Flash(array(
        'error' => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice' => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ));
});

/**
 * Flash service with custom CSS classes
 */
$di->set('flashSession', function () {
    return new FlashSession(array(
        'error' => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice' => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ));
});

/**
 * Custom authentication component
 */
$di->set('auth', function () {
    return new Auth();
});
/**
 * Mail service uses Swift Mail
 */
$di->set('mail', function () {
    return new Mail();
});

/**
 * Setting up the view component
 */
$di->set('view', function() use ($config) {

	$view = new View();

	$view->setViewsDir($config->application->viewsDir);
	$view->setPartialsDir($config->application->partialsDir);
	$view->setLayoutsDir($config->application->layoutsDir);

	$view->registerEngines(array(
		'.volt' => function($view, $di) use ($config) {

			$volt = new VoltEngine($view, $di);

			$volt->setOptions(array(
				'compiledPath' => $config->application->cacheDir,
				'compiledSeparator' => '_',
			));

		    $compiler = $volt->getCompiler();

			$compiler->addFilter('number', 'number_format');

			$compiler->addFilter('dump', 'print_r');
			$compiler->addFilter('array_sum', 'array_sum');
			$compiler->addFilter('get_object_vars', 'get_object_vars');
			$compiler->addFilter('positive', 'abs');
			$compiler->addFilter('round', 'round');
			$compiler->addFunction('number_format', 'number_format');
			$compiler->addFunction('strtotime', 'strtotime');
			$compiler->addFilter('stripspace', function($resolvedArgs, $exprArgs){
		        return 'str_replace(\' \',\'\','.$resolvedArgs.')';
			});
			$compiler->addFilter('timeAgo', function($resolvedArgs, $exprArgs){
		        return '\Carbon\Carbon::createFromFormat("Y-m-d H:i:s", '.$resolvedArgs.')->diffForHumans()';
			});
			$compiler->addFilter('money', function($resolvedArgs, $exprArgs){
		        return '"$" . number_format('.$resolvedArgs.', 2)';
			});
			$compiler->addFilter('initials', function($resolvedArgs, $exprArgs){
		    	return  'Elements::initials(' . $resolvedArgs . ');';
			});

			$compiler->addFilter('timeAgoDate', function($resolvedArgs, $exprArgs){
		        return '\Carbon\Carbon::createFromFormat("Y-m-d", '.$resolvedArgs.')->diffForHumans()';
			});

			return $volt;
		},
		'.phtml' => 'Phalcon\Mvc\View\Engine\Php'
	));

	return $view;
}, true);

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->set('db', function() use ($config) {
	return new DbAdapter(array(
		'host' => $config->database->host,
		'username' => $config->database->username,
		'password' => $config->database->password,
		'dbname' => $config->database->dbname
	));
});

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->set('modelsMetadata', function() use ($config) {
	return new MetaDataAdapter();
});

/**
 * Model cache service
 */
$di->set(
    'modelsCache',
    function () {
        // Cache data for one day (default setting)
        $frontCache = new FrontendData(
            [
                'lifetime' => 86400,
            ]
        );

        // Memcached connection settings
        $cache = new BackendMemcache(
            $frontCache,
            [
                'host' => 'localhost',
                'port' => '11211',
            ]
        );

        return $cache;
    }
);

/**
 * Start the session the first time some component request the session service
 */
$di->set('session', function() {
	$session = new SessionAdapter();
	$session->start();
	return $session;
});

// Register a user component
$di->set('elements', function () {
	return new Elements();
});

/**
 * Dispatcher use a default namespace, set events managers and manage 404 errors
 */

$di->set(
    'dispatcher',
    function() use ($di) {

        $evManager = $di->getShared('eventsManager');

        $evManager->attach(
            "dispatch:beforeException",
            function($event, $dispatcher, $exception)
            {
                switch ($exception->getCode()) {
                    case Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
                    case Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
                        $dispatcher->forward(
                            array(
                                'controller' => 'error',
                                'action'     => 'show404',
                            )
                        );
                        return false;
                }
            }
        );
        $dispatcher = new Dispatcher();
    	$dispatcher->setDefaultNamespace('App\Controllers');
        $dispatcher->setEventsManager($evManager);
        return $dispatcher;
    },
    true
);
/**
 * Access Control List
 */
$di->set('acl', function () {
    return new Acl();
});
