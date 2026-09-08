<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Sync\\', 'test');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
