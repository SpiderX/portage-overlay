<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Dns\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions.php',
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Amp/Cache/autoload.php',
	'/usr/share/php/Amp/Parser/autoload.php',
	'/usr/share/php/Amp/WindowsRegistry/autoload.php',
	'/usr/share/php/LibDNS/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);
