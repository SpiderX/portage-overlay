<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Tests\\Prophecy\\', 'tests');
Fedora\Autoloader\Autoload::addPsr4('Fixtures\\Prophecy\\', 'fixtures');

\Fedora\Autoloader\Dependencies::required([
	'src/Prophecy/autoload.php',
]);
