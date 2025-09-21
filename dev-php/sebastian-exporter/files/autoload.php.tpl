<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
	array(
		___CLASSLIST___,
	),
	__DIR__
);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/SebastianBergmann/RecursionContext/autoload.php',
]);
