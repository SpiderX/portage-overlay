<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Seld\\Signal\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../src/autoload.php',
]);
