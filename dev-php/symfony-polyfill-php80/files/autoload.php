<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Php80\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	'attribute' => '/Resources/stubs/Attribute.php',
	'phptoken' => '/Resources/stubs/PhpToken.php',
	'stringable' => '/Resources/stubs/Stringable.php',
	'unhandledmatcherror' => '/Resources/stubs/UnhandledMatchError.php',
	'valueerror' => '/Resources/stubs/ValueError.php',
    ),
    __DIR__
);
