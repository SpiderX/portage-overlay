<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Http\\Server\\Test\\', 'test');

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../test/functions.php',
	'src/autoload.php',
	'/usr/share/php/Amp/Http/Client/autoload.php',
]);
