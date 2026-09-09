<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Polyfill\\Php85\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/bootstrap.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
	array(
		'delayedtargetvalidation' => '/DelayedTargetValidation.php',
		'filter\\filterexception' => '/Filter/FilterException.php',
		'filter\\filterfailedexception' => '/Filter/FilterFailedException.php',
		'nodiscard' => '/NoDiscard.php'
	),
	__DIR__
);
