<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'tests/autoload.php',
	'/usr/share/php/PHPUnit/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
]);
