<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\Pipeline\\', 'test');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
	'/usr/share/php/Amp/PHPUnit/autoload.php',
]);
