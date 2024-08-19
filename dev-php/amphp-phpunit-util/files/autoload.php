<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\PHPUnit\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Amp/autoload.php',
	'/usr/share/php/PHPUnit/autoload.php',
	'/usr/share/php/Revolt/autoload.php',
]);
