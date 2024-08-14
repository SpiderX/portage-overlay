<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/_fixture/functions_that_declare_return_types.php',
	__DIR__ . '/../tests/_fixture/callback_function.php',
	'tests/autoload.php'
]);
