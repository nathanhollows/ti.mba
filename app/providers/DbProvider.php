<?php

declare(strict_types=1);

namespace App\Providers;

use Phalcon\Config;
use Phalcon\Db\Adapter\Pdo;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use RuntimeException;

class DbProvider implements ServiceProviderInterface
{
    protected $providerName = 'db';

    protected $adapters = [
        'mysql'  => Pdo\Mysql::class,
        'pgsql'  => Pdo\Postgresql::class,
        'sqlite' => Pdo\Sqlite::class,
    ];


    public function register(DiInterface $di): void
    {
        $config = $di->getShared('config')->get('database');
        $class  = $this->getClass($config);
        $config = $this->createConfig($config);

        $di->set($this->providerName, function () use ($class, $config) {
            return new $class($config);
        });

        // Check if the DB connection is successful
        try {
            $this->checkConnection($di->getShared($this->providerName));
        } catch (\Exception $e) {
            throw new RuntimeException(
                sprintf(
                    'Database connection error: %s',
                    $e->getMessage()
                )
            );
        }
    }

    private function checkConnection($db)
    {
        try {
            $db->connect();
        } catch (\Exception $e) {
            throw new RuntimeException(
                sprintf(
                    'Database connection error: %s',
                    $e->getMessage()
                )
            );
        }
    }

    private function getClass(Config $config): string
    {
        $name = $config->get('adapter', 'Unknown');

        if (empty($this->adapters[$name])) {
            throw new RuntimeException(
                sprintf(
                    'Adapter "%s" has not been registered',
                    $name
                )
            );
        }

        return $this->adapters[$name];
    }

    private function createConfig(Config $config): array
    {
        // To prevent error: SQLSTATE[08006] [7] invalid connection option "adapter"
        $dbConfig = $config->toArray();
        unset($dbConfig['adapter']);

        $name = $config->get('adapter');
        switch ($this->adapters[$name]) {
            case Pdo\Sqlite::class:
                // Resolve database path
                $dbConfig['dbname'] = "/var/www/html/db/{$config->get('dbname')}.sqlite3";
                break;
            case Pdo\Postgresql::class:
                // Postgres does not allow the charset to be changed in the DSN.
                unset($dbConfig['charset']);
                break;
        }

        return $dbConfig;
    }
}
