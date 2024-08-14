<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Bridge\\Doctrine\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Common/EventManager/autoload.php',
	'/usr/share/php/Doctrine/Persistence/autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Ctype/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
]);
