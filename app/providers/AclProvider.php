<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use App\Timba;
use App\Plugins\Acl\Acl;

class AclProvider implements ServiceProviderInterface
{
    protected $providerName = 'acl';

    public function register(DiInterface $di): void
    {
        $application = $di->getShared(Timba::APPLICATION_PROVIDER);

        $rootPath = $application->getRootPath();

        $di->setShared($this->providerName, function () use ($rootPath) {
            $filename         = $rootPath . '/config/acl.php';
            $privateResources = [];
            if (is_readable($filename)) {
                $privateResources = include $filename;
                if (!empty($privateResources['private'])) {
                    $privateResources = $privateResources['private'];
                }
            }

            $acl = new Acl();

            return $acl;
        });
    }
}
