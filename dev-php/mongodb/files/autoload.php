<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('MongoDB\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	'/usr/share/php/Jean85/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php80/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php81/autoload.php',
]);
