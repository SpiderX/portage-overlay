<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Cache\\IntegrationTests\\Tests\\', 'tests/');

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
]);
