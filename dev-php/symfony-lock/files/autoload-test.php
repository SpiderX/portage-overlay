<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Doctrine/DBAL/autoload.php',
	'/usr/share/php/MongoDB/autoload.php'
	'/usr/share/php/Predis/autoload.php',
]);
