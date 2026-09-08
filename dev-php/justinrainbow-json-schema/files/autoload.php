<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('JsonSchema\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/MabeEnum/autoload.php',
]);
