<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Component/Filesystem/autoload.php',
	'/usr/share/php/Symfony/Component/Finder/autoload.php',
	'/usr/share/php/Symfony/Component/VarExporter/autoload.php',
]);
