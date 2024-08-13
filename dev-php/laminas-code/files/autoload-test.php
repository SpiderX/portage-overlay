<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('LaminasTest\\Code\\', 'test');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Doctrine/Common/Annotations/autoload.php',
	'/usr/share/php/Laminas/Stdlib/autoload.php',
]);
