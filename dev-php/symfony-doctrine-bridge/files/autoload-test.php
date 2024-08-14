<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Doctrine/Common/DataFixtures/autoload.php',
	'/usr/share/php/Doctrine/DBAL/autoload.php',
	'/usr/share/php/Doctrine/ORM/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Bridge/ProxyManager/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/Config/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/Form/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/Lock/autoload.php',
	'/usr/share/php/Symfony/Component/Security/Core/autoload.php',
	'/usr/share/php/Symfony/Component/Stopwatch/autoload.php',
	'/usr/share/php/Symfony/Component/Validator/autoload.php',
	'/usr/share/php/Symfony/Component/Uid/autoload.php',
]);
