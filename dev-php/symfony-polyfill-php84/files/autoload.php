<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Php84\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
	array(
		'deprecated' => '/Resources/stubs/Deprecated.php',
		'reflectionconstant' => '/Resources/stubs/ReflectionConstant.php',
	),
	__DIR__
);
