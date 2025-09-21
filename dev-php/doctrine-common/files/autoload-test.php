<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'tests/DoctrineTestCase.php',
]);
