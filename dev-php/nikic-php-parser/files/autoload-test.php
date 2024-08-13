<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('PhpParser\\', 'test/PhpParser/');

\Fedora\Autoloader\Dependencies::required([
	'lib/PhpParser/autoload.php'
]);
