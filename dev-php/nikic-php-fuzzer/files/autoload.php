<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('PhpFuzzer\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/GetOpt/src/autoload.php',
	'/usr/share/php/nikic/IncludeInterceptor/autoload.php',
	'/usr/share/php/nikic/PhpParser/autoload.php',
]);
