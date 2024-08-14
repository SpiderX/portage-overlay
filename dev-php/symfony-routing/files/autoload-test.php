<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Doctrine/Common/Annotations/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/Config/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/ExpressionLanguage/autoload.php',
	'/usr/share/php/Symfony/Component/HttpFoundation/autoload.php',
	'/usr/share/php/Symfony/Component/Yaml/autoload.php',
]);
