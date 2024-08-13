<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\DBAL\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
]);
