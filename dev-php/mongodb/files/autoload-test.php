<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('MongoDB\\Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/PHPUnit/Functions.php',
	'src/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
]);
