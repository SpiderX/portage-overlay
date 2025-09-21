<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Composer\\Pcre\\', 'test/');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	__DIR__ . '/../tests/BaseTestCase.php',
]);
