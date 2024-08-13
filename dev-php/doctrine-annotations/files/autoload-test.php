<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../tests/Doctrine/Tests/Common/Annotations/Fixtures/functions.php',
	__DIR__ . '/../tests/Doctrine/Tests/Common/Annotations/Fixtures/SingleClassLOC1000.php',
	'lib/Doctrine/Common/Annotations/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
]);
