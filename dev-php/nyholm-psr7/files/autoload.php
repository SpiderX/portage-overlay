<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Nyholm\\Psr7\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Http/Message/Factory/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
