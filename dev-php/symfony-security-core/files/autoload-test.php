<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/ExpressionLanguage/autoload.php',
	'/usr/share/php/Symfony/Component/HttpFoundation/autoload.php',
	'/usr/share/php/Symfony/Component/Translation/autoload.php',
	'/usr/share/php/Symfony/Component/Validator/autoload.php',
]);
