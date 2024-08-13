<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('phpDocumentor\\Reflection\\', 'tests/unit');
Fedora\Autoloader\Autoload::addPsr4('phpDocumentor\\Reflection\\', 'tests/integration');

\Fedora\Autoloader\Dependencies::required([
	'src/DocBlock/autoload.php',
	'/usr/share/php/Mockery/autoload.php',
]);
