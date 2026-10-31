<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'ezc/Base/autoload.php',
]);

\Fedora\Autoloader\Autoload::addClassMap(
	array(
		___CLASSLIST___,
	),
	__DIR__
);
