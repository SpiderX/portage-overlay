<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Psr\\Http\\Client\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
