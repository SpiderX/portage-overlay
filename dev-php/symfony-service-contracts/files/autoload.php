<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Contracts\\Service\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Container/autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
]);
