<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Fixture\\', 'tests/Fixture/');
Fedora\Autoloader\Autoload::addPsr4('Mockery\\Tests\\Unit\\', 'tests/Unit');
Fedora\Autoloader\Autoload::addPsr4('test\\', 'tests/');

\Fedora\Autoloader\Dependencies::required([
	'library/autoload.php',
]);
