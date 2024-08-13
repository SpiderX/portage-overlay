<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests\\', 'tests');
Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests_PHP74\\', 'tests_php74');
Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests_PHP81\\', 'tests_php81');

\Fedora\Autoloader\Dependencies::required([
	'src/Persistence/autoload.php',
	'/usr/share/php/Doctrine/Common/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
]);
