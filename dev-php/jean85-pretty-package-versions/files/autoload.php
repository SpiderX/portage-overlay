<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Jean85\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Composer/autoload.php',
]);
