<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\DBAL\\Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/Console/autoload.php',
]);
