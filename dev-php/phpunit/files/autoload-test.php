<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/_files/CoveredFunction.php',
	__DIR__ . '/../tests/_files/Generator.php',
	__DIR__ . '/../tests/_files/NamespaceCoveredFunction.php',
	'src/autoload.php',
	'tests/unit/autoload.php',
	'tests/_files/autoload.php',
	'tests/end-to-end/execution-order/_files/autoload.php',
	'tests/end-to-end/event/autoload.php',
	'tests/end-to-end/regression/autoload.php',
	'tests/end-to-end/testdox/autoload.php',
]);
