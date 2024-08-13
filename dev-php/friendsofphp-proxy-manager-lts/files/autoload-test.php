<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('ProxyManagerTest\\', 'tests/ProxyManagerTest');
Fedora\Autoloader\Autoload::addPsr4('ProxyManagerTestAsset\\', 'tests/ProxyManagerTestAsset');

\Fedora\Autoloader\Dependencies::required([
	'src/ProxyManager/autoload.php',
]);
