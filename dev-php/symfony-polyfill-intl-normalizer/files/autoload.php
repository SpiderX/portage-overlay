<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Intl\\Normalizer\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	'normalizer' => '/Resources/stubs/Normalizer.php',
    ),
    __DIR__
);
