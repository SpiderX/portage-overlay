<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Security\\Core\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Contracts/EventDispatcher/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/PasswordHasher/autoload.php',
]);
