<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	__DIR__ . '/../tests/_fixture/TestCallable.php',
]);
