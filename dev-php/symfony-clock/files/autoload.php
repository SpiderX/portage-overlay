<?php

require_once 'Fedora/Autoloader/autoload.php';
#require_once 'Resources/now.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Clock\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/Resources/now.php',
	'/usr/share/php/Psr/Clock/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php83/autoload.php',
]);
