<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Twig\\Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Psr/Container/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
]);
