<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	__DIR__ . '/Future/functions.php',
	__DIR__ . '/Internal/functions.php',
	'/usr/share/php/Revolt/autoload.php',
]);
