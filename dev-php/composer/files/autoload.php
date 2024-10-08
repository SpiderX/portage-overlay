<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Composer\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Composer/CaBundle/autoload.php',
	'/usr/share/php/Composer/ClassMapGenerator/autoload.php',
	'/usr/share/php/Composer/MetadataMinifier/autoload.php',
	'/usr/share/php/Composer/Pcre/autoload.php',
	'/usr/share/php/Composer/Semver/autoload.php',
	'/usr/share/php/Composer/XdebugHandler/autoload.php',
	'/usr/share/php/Composer/Spdx/autoload.php',
	'/usr/share/php/JsonSchema/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/React/Promise/autoload.php',
	'/usr/share/php/Seld/JsonLint/autoload.php',
	'/usr/share/php/Seld/PharUtils/autoload.php',
	'/usr/share/php/Seld/SignalHandler/autoload.php',
	'/usr/share/php/Symfony/Contracts/Deprecation/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/Console/autoload.php',
	'/usr/share/php/Symfony/Component/Filesystem/autoload.php',
	'/usr/share/php/Symfony/Component/Finder/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/String/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Ctype/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Intl/Normalizer/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Mbstring/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Intl/Grapheme/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php80/autoload.php',
	'/usr/share/php/Symfony/Polyfill/Php81/autoload.php',
]);
