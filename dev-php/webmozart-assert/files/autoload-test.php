<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Webmozart\\Assert\\Bin\\', 'bin/src');
Fedora\Autoloader\Autoload::addPsr4('Webmozart\\Assert\\Tests\\', 'tests/');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
