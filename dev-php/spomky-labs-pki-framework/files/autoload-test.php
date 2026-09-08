<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('SpomkyLabs\\Pki\\Test\\', 'tests/');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
