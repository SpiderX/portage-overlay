<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('ProxyManager\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Laminas/Code/autoload.php',
	'/usr/share/php/Symfony/Component/Filesystem/autoload.php',
]);
