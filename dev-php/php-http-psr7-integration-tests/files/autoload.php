<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Http\\Psr7Test\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/PHPUnit/vendor/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
