<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('League\\Uri\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/League/Uri/Interfaces/autoload.php',
	'/usr/share/php/Psr/Http/Message/Factory/autoload.php',
]);
