<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('DaveRandom\\CallbackValidator\\Test\\', 'tests/');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
