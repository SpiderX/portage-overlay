<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\File\\Test\\', 'test');
Fedora\Autoloader\Autoload::addPsr4('Amp\\Cache\\Test\\', 'vendor/amphp/cache/test');
Fedora\Autoloader\Autoload::addPsr4('Amp\\Sync\\', 'vendor/amphp/sync/test');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
