<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('DaveRandom\\LibDNS\\Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/DaveRandom/CallbackValidator/autoload.php',
	'/usr/share/php/DaveRandom/Enum/autoload.php',
	'/usr/share/php/DaveRandom/Network/autoload.php',
	'/usr/share/php/NetworkInterop/autoload.php',
]);
