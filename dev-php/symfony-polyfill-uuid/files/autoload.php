<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Uuid\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);