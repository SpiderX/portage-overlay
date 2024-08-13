<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Php81\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	'curlstringfile' => '/Resources/stubs/CURLStringFile.php',
	'returntypewillchange' => '/Resources/stubs/ReturnTypeWillChange.php',
    ),
    __DIR__
);
