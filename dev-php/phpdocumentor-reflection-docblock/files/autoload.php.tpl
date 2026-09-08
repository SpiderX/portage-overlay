<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	___CLASSLIST___,
    ),
    __DIR__
);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/phpDocumentor/Reflection/TypeResolver/autoload.php',
	'/usr/share/php/Webmozart/Assert/autoload.php',
	'/usr/share/php/phpDocumentor/Reflection/Common/autoload.php',
	'/usr/share/php/PHPStan/PhpDocParser/autoload.php',
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
]);
