<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Cache/IntegrationTests/autoload.php',
	'/usr/share/php/Doctrine/DBAL/autoload.php',
	'/usr/share/php/Predis/autoload.php',
	'/usr/share/php/Psr/SimpleCache/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Component/Clock/autoload.php',
	'/usr/share/php/Symfony/Component/Config/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/Filesystem/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/autoload.php',
	'/usr/share/php/Symfony/Component/VarDumper/autoload.php',
]);
