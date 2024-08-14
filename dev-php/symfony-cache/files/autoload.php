<?php

require_once 'Fedora/Autoloader/autoload.php';
#require_once 'Traits/ValueWrapper.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Cache\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/Traits/ValueWrapper.php',
	'/usr/share/php/Psr/Cache/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Symfony/Contracts/Cache/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/VarExporter/autoload.php',
]);
