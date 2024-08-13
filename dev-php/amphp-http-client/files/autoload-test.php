<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Http\\Client\\', 'test');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Amp/File/autoload.php',
	'/usr/share/php/Amp/Http/Server/autoload.php',
	'/usr/share/php/Laminas/Diactoros/autoload.php',
]);
