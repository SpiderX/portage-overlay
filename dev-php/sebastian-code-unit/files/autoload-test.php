<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/_fixture/file_with_multiple_code_units.php',
	__DIR__ . '/../tests/_fixture/function.php',
	__DIR__ . '/../tests/_fixture/issue_9.php',
	'src/autoload.php',
	'tests/autoload.php',
]);
