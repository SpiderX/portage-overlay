<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/PHPStan/PhpDocParser/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
]);
