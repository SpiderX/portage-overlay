<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests\\', 'tests/Doctrine/Tests');

\Fedora\Autoloader\Dependencies::required([
	'lib/Doctrine/Common/Cache/autoload.php',
	'/usr/share/php/Cache/IntegrationTests/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/VarExporter/autoload.php',
]);
