<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('React\\Promise\\', 'tests/');
Fedora\Autoloader\Autoload::addPsr4('React\\Promise\\', 'tests/fixtures/');

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../src/autoload.php',
]);
