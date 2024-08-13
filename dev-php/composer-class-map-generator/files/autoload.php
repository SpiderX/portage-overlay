<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Composer\\ClassMapGenerator\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Symfony/Component/Finder/autoload.php',
	'/usr/share/php/Composer/Pcre/autoload.php',
]);


