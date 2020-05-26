<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Config;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt;

class ViewProvider implements ServiceProviderInterface
{

	protected $providerName = 'view';

	public function register(DiInterface $di): void
	{
		$config = $di->getShared('config');

		$di->setShared($this->providerName, function () use ($config, $di) {
			$view = new View();
			$cacheDir = $config->path('application.cacheDir');
			$view->setViewsDir($config->path('application.viewsDir'));
			$view->setPartialsDir($config->path('application.partialsDir'));
			$view->setLayoutsDir($config->path('application.layoutsDir'));
			$view->registerEngines([
				'.volt' => function (View $view) use ($cacheDir, $di) {
					$volt = new Volt($view, $di);
					$volt->setOptions([
						'path'      => $cacheDir . 'volt/',
						'separator' => '_',
					]);


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
					$compiler->addFunction('icon', function($resolvedArgs, $exprArgs) {
						return 'file_get_contents("img/icons/' . trim($resolvedArgs,"'") . '.svg")';
					});

					return $volt;
				},
			]);

			return $view;
		});
	}
}
