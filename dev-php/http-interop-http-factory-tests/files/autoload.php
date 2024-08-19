<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Interop\\Http\\Factory\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/PHPUnit/autoload.php',
	'/usr/share/php/Psr/Http/Message/Factory/autoload.php',
]);
