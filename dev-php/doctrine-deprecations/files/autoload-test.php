<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('DeprecationTests\\', 'test_fixtures/src');
Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Foo\\', 'test_fixtures/vendor/doctrine/foo');

\Fedora\Autoloader\Dependencies::required([
	'lib/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
]);
