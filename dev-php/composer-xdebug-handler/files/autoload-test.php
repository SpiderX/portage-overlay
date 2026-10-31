<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Composer\\XdebugHandler\\Tests\\', __DIR__ . '/../tests');

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../src/autoload.php',
]);
