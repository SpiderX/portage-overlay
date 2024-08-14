<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/_fixture/ExampleEnum.php',
	__DIR__ . '/../tests/_fixture/ExampleIntegerBackedEnum.php',
	__DIR__ . '/../tests/_fixture/ExampleStringBackedEnum.php',
	'tests/autoload.php'
]);
