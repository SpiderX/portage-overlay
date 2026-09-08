<?php

require_once 'Fedora/Autoloader/autoload.php';


Fedora\Autoloader\Autoload::addPsr4('Prophecy\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Instantiator/autoload.php',
	'/usr/share/php/phpDocumentor/Reflection/DocBlock/autoload.php',
	'/usr/share/php/SebastianBergmann/Comparator/autoload.php',
	'/usr/share/php/SebastianBergmann/RecursionContext/autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
]);
