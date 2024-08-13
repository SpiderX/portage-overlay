<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Http\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	__DIR__ . '/Internal/constants.php',
	'/usr/share/php/Amp/Http/Internal/autoload.php',
	'/usr/share/php/Amp/Parser/autoload.php',
	'/usr/share/php/League/Uri/Components/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
