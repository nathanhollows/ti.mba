<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Escaper;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Flash\Session as FlashSession;

class FlashSessionProvider implements ServiceProviderInterface
{

    protected $providerName = 'flashSession';

    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, function () {
			$session = $this->getShared('session');
            $flash = new FlashSession(null, $session);
			$flash->setAutoEscape(false);
            $flash->setCssClasses([
                'error'   => 'alert alert-danger',
                'success' => 'alert alert-success',
                'notice'  => 'alert alert-info',
                'warning' => 'alert alert-warning',
            ]);

            return $flash;
        });
    }
}
