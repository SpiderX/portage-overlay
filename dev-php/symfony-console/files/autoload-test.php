<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/EventDispatcher/autoload.php',
	'/usr/share/php/Symfony/Component/Lock/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/VarDumper/autoload.php',
]);
