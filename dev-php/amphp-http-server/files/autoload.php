<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Http\\Server\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	__DIR__ . '/Driver/functions.php',
	__DIR__ . '/Middleware/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Amp/Cache/autoload.php',
	'/usr/share/php/Amp/Http/Internal/autoload.php',
	'/usr/share/php/Amp/Http/autoload.php',
	'/usr/share/php/Amp/Pipeline/autoload.php',
	'/usr/share/php/Amp/Socket/autoload.php',
	'/usr/share/php/Amp/Sync/autoload.php',
	'/usr/share/php/League/Uri/autoload.php',
	'/usr/share/php/League/Uri/Interfaces/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);


