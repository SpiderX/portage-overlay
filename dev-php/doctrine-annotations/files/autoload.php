<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Common\\Annotations\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Common/Lexer/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
]);


