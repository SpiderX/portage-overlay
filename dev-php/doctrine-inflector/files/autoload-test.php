<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests\\Inflector\\', 'tests/Doctrine/Tests/Inflector');

\Fedora\Autoloader\Dependencies::required([
	'lib/Doctrine/Inflector/autoload.php',
]);
