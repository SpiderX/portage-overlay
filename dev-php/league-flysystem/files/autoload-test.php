<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('League\\Flysystem\\AdapterTestUtilities\\', 'src/AdapterTestUtilities');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/GuzzleHttp/Psr7/autoload.php',
#	'tests/autoload.php',
]);
