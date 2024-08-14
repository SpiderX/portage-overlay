<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Form\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/EventDispatcher/autoload.php',
	'/usr/share/php/Symfony/Component/OptionsResolver/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Ctype/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Intl/Icu/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
]);
