<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Http\\Client\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	__DIR__ . '/Internal/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Amp/Http/autoload.php',
	'/usr/share/php/Amp/Http/Internal/autoload.php',
	'/usr/share/php/Amp/Pipeline/autoload.php',
	'/usr/share/php/Amp/Socket/autoload.php',
	'/usr/share/php/Amp/Sync/autoload.php',
	'/usr/share/php/League/Uri/autoload.php',
	'/usr/share/php/League/Uri/Components/autoload.php',
	'/usr/share/php/League/Uri/Interfaces/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);


