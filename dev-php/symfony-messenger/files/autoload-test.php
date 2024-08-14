<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Bridge/Doctrine/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/Console/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/EventDispatcher/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/Bridge/Amqp/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/Bridge/Doctrine/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Component/RateLimiter/autoload.php',
	'/usr/share/php/Symfony/Component/Routing/autoload.php',
	'/usr/share/php/Symfony/Component/Serializer/autoload.php',
	'/usr/share/php/Symfony/Component/Stopwatch/autoload.php',
	'/usr/share/php/Symfony/Component/Validator/autoload.php',
]);
