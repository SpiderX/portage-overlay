<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Parallel\\Test\\', 'test');
Fedora\Autoloader\Autoload::addPsr4('App\\Worker\\', 'examples/worker');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
