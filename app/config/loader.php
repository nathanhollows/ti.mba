<?php

$loader = new \Phalcon\Loader();

date_default_timezone_set('NZ');

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerNamespaces(
	array(
        'App\Controllers'           => $config->application->controllersDir,
		'App\Controllers\Mobile'	=> $config->application->mobileControllersDir,
		'App\Models' 		        => $config->application->modelsDir,
		'App\Forms' 		        => $config->application->formsDir,
		'App\Providers'		        => $config->application->providersDir,
		'App' 				        => $config->application->libraryDir,
	)
)->register();
