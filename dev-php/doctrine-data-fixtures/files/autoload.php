<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Common\\DataFixtures\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Doctrine/Persistence/autoload.php',
]);
