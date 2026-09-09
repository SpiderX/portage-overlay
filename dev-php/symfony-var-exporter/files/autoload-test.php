<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Component/Serializer/autoload.php',
	'/usr/share/php/Symfony/Component/VarDumper/autoload.php',
]);
