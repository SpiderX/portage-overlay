<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Symfony/Component/HttpFoundation/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
]);
