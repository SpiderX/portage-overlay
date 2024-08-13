<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Http\\Client\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Http/Promise/autoload.php',
	'/usr/share/php/Psr/Http/Client/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
