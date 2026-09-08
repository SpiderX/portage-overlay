<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Tests\\', 'tests');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);

\Composer\InstalledVersions::reload(
	require __DIR__.'/installed.php'
);
