<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('GuzzleHttp\\Tests\\Psr7\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Interop/Http/Factory/autoload.php',
]);
