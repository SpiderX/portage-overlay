<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Component/ErrorHandler/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php81/autoload.php',
]);
