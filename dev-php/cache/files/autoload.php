<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Cache\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Common/Cache/autoload.php',
	'/usr/share/php/League/Flysystem/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Psr/SimpleCache/autoload.php',
]);
