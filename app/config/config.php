<?php

return new \Phalcon\Config(array(
	'database' => array(
		// Describe how the app is to connect to the database
		'adapter'     => 'Mysql',
		'host'        => 'localhost',
		'username'    => 'admin',
		'password'    => 'DUpace11',
		'dbname'      => 'avaunt',
	),
	'application' => array(
		// Define the folders for various components
		'controllersDir' => __DIR__ . '/../../app/controllers/',
		'modelsDir'      => __DIR__ . '/../../app/models/',
		'viewsDir'       => __DIR__ . '/../../app/views/',
		'formsDir'       => __DIR__ . '/../../app/forms/',
		'partialsDir'    => 'partials/',
		'layoutsDir'     => 'layouts/',
		'pluginsDir'     => __DIR__ . '/../../app/plugins/',
		'libraryDir'     => __DIR__ . '/../../app/library/',
		'cacheDir'       => __DIR__ . '/../../app/cache/',
		'baseUri'        => '/avaunt/',
		// Set the root URI
		// Define the site title
		'siteTitle'		 => 'Avaunt',
		// Define version number
		'version'		 => '0.1'
	),
	'pbt' => array(
		'enable'		=> false,
		'ftpServer'		=> '',
		'ftpUserName'	=> '',
		'ftpPassword'	=> '',
		'ftpDirectory'	=> ''
		// Toggle PBT file downloads
		// Use value supplied by PBT
		// No slashes required
	),
));
