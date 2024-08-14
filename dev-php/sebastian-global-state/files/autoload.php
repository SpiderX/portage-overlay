<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/_fixture/SnapshotFunctions.php',
	'tests/autoload.php',
	'/usr/share/php/SebastianBergmann/ObjectReflector/autoload.php'
]);
