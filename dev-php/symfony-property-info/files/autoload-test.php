<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/phpDocumentor/Reflection/DocBlock/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/Serializer/autoload.php',
]);
