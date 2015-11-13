<?php

error_reporting(E_ALL);

try {


	/**
	 * Read the configuration
	 */
	$config = include __DIR__ . "/../app/config/config.php";

	define('SITE_TITLE', $config->application->siteTitle);
	define('BASE_DIR', dirname(__DIR__));
	define('APP_DIR', BASE_DIR . '/app');

	/**
	 * Read auto-loader
	 */
	include __DIR__ . "/../app/config/loader.php";

	/**
	 * Read services
	 */
	include __DIR__ . "/../app/config/services.php";

	/**
	 * Handle the request
	 */
	$application = new \Phalcon\Mvc\Application();
	$application->setDI($di);
	echo $application->handle()->getContent();

} catch (Phalcon\Exception $e) {
	echo $e->getMessage();
} catch (PDOException $e){
	echo $e->getMessage();
}