<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Prophecy\\PhpUnit\\Tests\\', 'tests');
Fedora\Autoloader\Autoload::addPsr4('Prophecy\\PhpUnit\\Tests\\Fixtures\\', 'fixtures');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
