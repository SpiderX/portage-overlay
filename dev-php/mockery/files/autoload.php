<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Mockery\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/helpers.php',
	__DIR__ . '/Mockery.php',
	'/usr/share/php/Hamcrest/autoload.php',
]);
