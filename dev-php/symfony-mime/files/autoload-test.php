<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Egulias/EmailValidator/autoload.php',
	'/usr/share/php/League/HTMLToMarkdown/autoload.php',
	'/usr/share/php/phpDocumentor/Reflection/DocBlock/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyInfo/autoload.php',
	'/usr/share/php/Symfony/Component/Serializer/autoload.php',
]);
