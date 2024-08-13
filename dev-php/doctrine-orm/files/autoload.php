<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\ORM\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Common/Collections/autoload.php',
	'/usr/share/php/Doctrine/Common/EventManager/autoload.php',
	'/usr/share/php/Doctrine/Common/Lexer/autoload.php',
	'/usr/share/php/Doctrine/DBAL/autoload.php',
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Doctrine/Inflector/autoload.php',
	'/usr/share/php/Doctrine/Instantiator/autoload.php',
	'/usr/share/php/Doctrine/Persistence/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/Console/autoload.php',
	'/usr/share/php/Symfony/Component/VarExporter/autoload.php',
]);
