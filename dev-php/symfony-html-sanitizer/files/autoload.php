<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\HtmlSanitizer\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/League/Uri/autoload.php',
	'/usr/share/php/Masterminds/autoload.php',
]);
