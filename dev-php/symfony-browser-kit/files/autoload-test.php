<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Symfony/Component/CssSelector/autoload.php',
	'/usr/share/php/Symfony/Component/HttpClient/autoload.php',
	'/usr/share/php/Symfony/Component/Mime/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
]);
