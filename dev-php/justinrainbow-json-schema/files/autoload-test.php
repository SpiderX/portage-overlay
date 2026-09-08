<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('JsonSchema\\Tests\\', 'tests/');

\Fedora\Autoloader\Dependencies::required([
	'src/JsonSchema/autoload.php',
]);
