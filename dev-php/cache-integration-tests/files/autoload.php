<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Cache\\IntegrationTests\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Cache/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
]);
