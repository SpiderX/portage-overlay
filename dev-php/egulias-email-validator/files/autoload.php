<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Egulias\\EmailValidator\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Doctrine/Common/Lexer/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Intl/Idn/autoload.php',
]);
