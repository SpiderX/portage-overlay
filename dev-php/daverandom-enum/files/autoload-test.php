<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('DaveRandom\\Enum\\Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
