<?php

$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerNamespaces(
	array(
		'App\Controllers' => __DIR__ . '/../controllers/'
	)
)->register();

// Register some classes
$loader->registerClasses(
    array(
        'Elements'		=> __DIR__ . '/../library/Elements.php'
    )
)->register();

$loader->registerDirs(
	array(
		__DIR__ . $config->application->controllersDir,
		__DIR__ . $config->application->pluginsDir,
		__DIR__ . $config->application->libraryDir,
		__DIR__ . $config->application->modelsDir,
		__DIR__ . $config->application->formsDir,
	)
)->register();

$elements = new Elements();