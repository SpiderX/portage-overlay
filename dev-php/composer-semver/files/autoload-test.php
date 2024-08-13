<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Composer\\Semver\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
