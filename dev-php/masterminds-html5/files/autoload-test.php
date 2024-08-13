<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Masterminds\\HTML5\\Tests\\', 'test/HTML5');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
