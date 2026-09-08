<?php

require_once 'Fedora/Autoloader/autoload.php';

#Fedora\Autoloader\Autoload::addPsr4('DeepCopyTest\\', 'tests/DeepCopyTest/');
#Fedora\Autoloader\Autoload::addPsr4('DeepCopy\\', 'fixtures/');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
