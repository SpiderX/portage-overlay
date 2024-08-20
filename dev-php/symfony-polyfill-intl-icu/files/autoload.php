<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Intl\\Icu\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	'collator' => '/Resources/stubs/Collator.php',
	'intldateformatter' => '/Resources/stubs/IntlDateFormatter.php',
	'locale' => '/Resources/stubs/Locale.php',
	'numberformatter' => '/Resources/stubs/NumberFormatter.php',
    ),
    __DIR__
);
