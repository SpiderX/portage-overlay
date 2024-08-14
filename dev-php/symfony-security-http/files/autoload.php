<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Security\\Http\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/HttpFoundation/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Component/Security/Core/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
]);
