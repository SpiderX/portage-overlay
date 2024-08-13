<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Contracts/Translation/autoload.php',
	'/usr/share/php/Symfony/Component/ErrorHandler/autoload.php',
	'/usr/share/php/Symfony/Component/Intl/autoload.php',
]);
