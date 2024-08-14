<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\DomCrawler\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Masterminds/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Ctype/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
]);
