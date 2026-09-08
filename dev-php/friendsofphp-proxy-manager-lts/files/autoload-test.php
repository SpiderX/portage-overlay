<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('ProxyManagerTest\\', 'tests/ProxyManagerTest');
Fedora\Autoloader\Autoload::addPsr4('ProxyManagerTestAsset\\', 'tests/ProxyManagerTestAsset');
Fedora\Autoloader\Autoload::addPsr4('Laminas\\Server\\', 'tests/Stubbed/Laminas/Server');

\Fedora\Autoloader\Dependencies::required([
	'src/ProxyManager/autoload.php',
	'/usr/share/php/Composer/autoload.php',
]);
