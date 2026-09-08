<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('MabeEnumTest\\', 'tests/MabeEnumTest/');
Fedora\Autoloader\Autoload::addPsr4('MabeEnumStaticAnalysis\\', 'tests/MabeEnumStaticAnalysis/');

\Fedora\Autoloader\Dependencies::required([
	'src/autoload.php',
]);
