<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/ExpressionLanguage/autoload.php',
	'/usr/share/php/Symfony/Component/Mime/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/RateLimiter/autoload.php',
]);
