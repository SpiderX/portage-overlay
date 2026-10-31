<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('React\\Promise\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions_include.php',
]);
