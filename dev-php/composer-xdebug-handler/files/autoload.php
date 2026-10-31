<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Composer\\XdebugHandler\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Composer/Pcre/autoload.php',
]);
