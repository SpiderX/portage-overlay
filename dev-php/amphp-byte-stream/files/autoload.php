<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\ByteStream\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	__DIR__ . '/Internal/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/Parser/autoload.php',
	'/usr/share/php/Amp/Pipeline/autoload.php',
	'/usr/share/php/Amp/Serialization/autoload.php',
	'/usr/share/php/Amp/Sync/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);
