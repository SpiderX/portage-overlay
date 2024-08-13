<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('League\\Flysystem\\Local\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/League/Flysystem/autoload.php',
	'/usr/share/php/League/MimeTypeDetection/autoload.php',
]);
