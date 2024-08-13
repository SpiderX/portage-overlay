<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Parallel\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/Context/functions.php',
	__DIR__ . '/Context/Internal/functions.php',
	__DIR__ . '/Ipc/functions.php',
	__DIR__ . '/Worker/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Amp/Cache/autoload.php',
	'/usr/share/php/Amp/Parser/autoload.php',
	'/usr/share/php/Amp/Pipeline/autoload.php',
	'/usr/share/php/Amp/Process/autoload.php',
	'/usr/share/php/Amp/Serialization/autoload.php',
	'/usr/share/php/Amp/Socket/autoload.php',
	'/usr/share/php/Amp/Sync/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);
