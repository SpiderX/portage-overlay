<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('LaminasTest\\Diactoros\\', 'test');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Http/Psr7Test/autoload.php',
	'/usr/share/php/Interop/Http/Factory/autoload.php',
]);
