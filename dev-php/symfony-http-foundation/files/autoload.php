<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\HttpFoundation\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php83/autoload.php',
]);
