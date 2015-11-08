<?php

return new \Phalcon\Config(array(
	'database' => array(
		'adapter'     => 'Mysql',
		'host'        => 'localhost',
		'username'    => 'admin',
		'password'    => 'DUpace11',
		'dbname'      => 'avaunt',
	),
	'application' => array(
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
		'siteTitle'		 => 'Avaunt'
	)
));
