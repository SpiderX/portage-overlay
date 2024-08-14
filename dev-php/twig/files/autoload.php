<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Twig\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/Resources/core.php',
	__DIR__ . '/Resources/debug.php',
	__DIR__ . '/Resources/escaper.php',
	__DIR__ . '/Resources/string_loader.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Ctype/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php80/autoload.php',
]);
