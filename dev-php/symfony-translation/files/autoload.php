<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Translation\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Contracts/Translation/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
]);
