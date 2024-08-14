<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Amp/Http/Client/autoload.php',
	'/usr/share/php/Http/Client/autoload.php',
	'/usr/share/php/Http/Discovery/autoload.php',
	'/usr/share/php/GuzzleHttp/Promise/autoload.php',
	'/usr/share/php/Nyholm/Psr7/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/Stopwatch/autoload.php',
]);
