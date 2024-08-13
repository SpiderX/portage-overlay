<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Socket\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	__DIR__ . '/Internal/functions.php',
	__DIR__ . '/SocketAddress/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/Dns/autoload.php',
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Kelunik/Certificate/autoload.php',
	'/usr/share/php/League/Uri/autoload.php',
	'/usr/share/php/League/Uri/Interfaces/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);
