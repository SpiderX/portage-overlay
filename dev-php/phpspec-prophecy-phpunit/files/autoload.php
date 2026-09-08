<?php

require_once 'Fedora/Autoloader/autoload.php';


Fedora\Autoloader\Autoload::addPsr4('Prophecy\\PhpUnit\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/PHPUnit/autoload.php',
	'/usr/share/php/phpspec/Prophecy/autoload.php',
]);
