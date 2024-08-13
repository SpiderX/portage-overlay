<?php

require_once 'Fedora/Autoloader/autoload.php';
require_once 'tests/_files/CoveredFunction.php';
require_once 'tests/_files/Generator.php';
require_once 'tests/_files/NamespaceCoveredFunction.php';

\Fedora\Autoloader\Dependencies::required([
	'tests/unit/autoload.php',
	'tests/_files/autoload.php',
	'tests/end-to-end/execution-order/_files/autoload.php',
]);
