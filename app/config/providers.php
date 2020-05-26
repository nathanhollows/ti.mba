<?php
declare(strict_types=1);

/**
 * This file is part of the Vökuró.
 *
 * (c) Phalcon Team <team@phalcon.io>
 *
 * For the full copyright and license information, please view
 * the LICENSE file that was distributed with this source code.
 */

use App\Providers\AclProvider;
use App\Providers\AuthProvider;
use App\Providers\ConfigProvider;
use App\Providers\CryptProvider;
use App\Providers\DbProvider;
use App\Providers\DispatcherProvider;
use App\Providers\ElementsProvider;
use App\Providers\FlashProvider;
use App\Providers\FlashSessionProvider;
use App\Providers\LoggerProvider;
use App\Providers\MailProvider;
use App\Providers\ModelsMetadataProvider;
use App\Providers\RouterProvider;
use App\Providers\SecurityProvider;
use App\Providers\SessionBagProvider;
use App\Providers\SessionProvider;
use App\Providers\UrlProvider;
use App\Providers\ViewProvider;
use App\Providers\AssetsProvider;
use App\Providers\ModelsCacheProvider;

return [
    AssetsProvider::class,
    # LoggerProvider::class,
    SecurityProvider::class,
    AclProvider::class,
    AuthProvider::class,
    ConfigProvider::class,
    CryptProvider::class,
    DbProvider::class,
    DispatcherProvider::class,
    ElementsProvider::class,
    FlashProvider::class,
    FlashSessionProvider::class,
    MailProvider::class,
    ModelsCacheProvider::class,
    ModelsMetadataProvider::class,
    RouterProvider::class,
    SessionBagProvider::class,
    SessionProvider::class,
    UrlProvider::class,
    ViewProvider::class,
];
