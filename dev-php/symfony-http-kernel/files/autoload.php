<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\HttpKernel\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Component/ErrorHandler/autoload.php',
	'/usr/share/php/Symfony/Component/EventDispatcher/autoload.php',
	'/usr/share/php/Symfony/Component/HttpFoundation/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Ctype/autoload.php',
]);
