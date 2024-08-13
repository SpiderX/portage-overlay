<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr0('DoctrineTest\\InstantiatorPerformance\\', 'tests');
Fedora\Autoloader\Autoload::addPsr0('DoctrineTest\\InstantiatorTest\\', 'tests');
Fedora\Autoloader\Autoload::addPsr0('DoctrineTest\\InstantiatorTestAsset\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/Doctrine/Instantiator/autoload.php',
]);
