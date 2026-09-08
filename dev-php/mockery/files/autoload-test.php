<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Mockery\\', __DIR__ . '/../library/Mockery');
Fedora\Autoloader\Autoload::addPsr4('Tests\\Unit\\', __DIR__ . '/../tests/Unit');
Fedora\Autoloader\Autoload::addPsr0('', __DIR__ . '/../tests/Fixture/Namespaced');

foreach (['PHP73', 'PHP74', 'PHP80', 'PHP81', 'PHP82', 'PHP83', 'PHP84', 'PHP85', 'PHP86'] as $version) {
    Fedora\Autoloader\Autoload::addPsr4($version . '\\', __DIR__ . '/../tests/Fixture/' . $version);
}

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/../library/autoload.php',
	__DIR__ . '/../tests/Bootstrap.php',
]);
