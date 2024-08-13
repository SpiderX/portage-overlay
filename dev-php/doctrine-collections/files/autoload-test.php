<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Doctrine\\Tests\\Common\\Collections\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
