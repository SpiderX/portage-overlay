<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Php83\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	'dateerror' => '/Resources/stubs/DateError.php',
	'dateexception' => '/Resources/stubs/DateException.php',
	'dateinvalidoperationexception' => '/Resources/stubs/DateInvalidOperationException.php',
	'dateinvalidtimezoneexception' => '/Resources/stubs/DateInvalidTimeZoneException.php',
	'datemalformedintervalstringexception' => '/Resources/stubs/DateMalformedIntervalStringException.php',
	'datemalformedperiodstringexception' => '/Resources/stubs/DateMalformedPeriodStringException.php',
	'datemalformedstringexception' => '/Resources/stubs/DateMalformedStringException.php',
	'dateobjecterror' => '/Resources/stubs/DateObjectError.php',
	'daterangeerror' => '/Resources/stubs/DateRangeError.php',
	'override' => '/Resources/stubs/Override.php',
	'sqlite3exception' => '/Resources/stubs/SQLite3Exception.php',
    ),
    __DIR__
);
