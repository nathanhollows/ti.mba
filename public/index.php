<?php
use App\Timba as Application;

$rootPath = dirname(__DIR__);

try {

	/**
	 * Load in composer
	 */
	require_once((__DIR__) . '/../vendor/autoload.php');

	/**
	 * Read in config
	 */
	$config = include __DIR__ . "/../app/config/config.php";

	define('SITE_TITLE', $config->application->siteTitle);

	/**
	 * Read auto-loader
	 */
	include __DIR__ . "/../app/config/loader.php";

	echo (new Application($rootPath))->run();

} catch (Exception $e) {
	echo $e->getMessage(), '<br>';
	echo nl2br(htmlentities($e->getTraceAsString()));
}
