<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\File\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Amp/Cache/autoload.php',
	'/usr/share/php/Amp/Parallel/autoload.php',
	'/usr/share/php/Amp/Sync/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);
