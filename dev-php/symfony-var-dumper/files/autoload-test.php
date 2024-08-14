<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Component/Console/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/Uid/autoload.php',
	'/usr/share/php/Twig/autoload.php',
]);
