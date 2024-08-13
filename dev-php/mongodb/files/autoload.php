<?php

require_once 'Fedora/Autoloader/autoload.php';
require_once 'functions.php';

Fedora\Autoloader\Autoload::addPsr4('MongoDB\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Jean85/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php80/autoload.php',
	'/usr/share/php/Symfony/Component/Polyfill-php81/autoload.php'
]);
