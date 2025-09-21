<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('phpDocumentor\\Reflection\\', 'tests/unit');

\Fedora\Autoloader\Dependencies::required([
	'src/TypeResolver/autoload.php',
]);
