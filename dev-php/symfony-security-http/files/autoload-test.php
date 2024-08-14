<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Contracts/HttpClient/autoload.php',
	'/usr/share/php/Symfony/Component/ExpressionLanguage/autoload.php',
	'/usr/share/php/Symfony/Component/RateLimiter/autoload.php',
	'/usr/share/php/Symfony/Component/Routing/autoload.php',
	'/usr/share/php/Symfony/Component/Security/Csrf/autoload.php',
	'/usr/share/php/Symfony/Component/Translation/autoload.php',
]);
