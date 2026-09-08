<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
	array(
		___CLASSLIST___,
	),
	__DIR__
);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../src/autoload.php',
	__DIR__ . '/../tests/_fixture/callback_function.php',
	__DIR__ . '/../tests/_fixture/class_alias.php',
	__DIR__ . '/../tests/_fixture/functions_that_declare_return_types.php',
]);
