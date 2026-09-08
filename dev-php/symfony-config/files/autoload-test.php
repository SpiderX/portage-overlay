<?php

require_once 'Fedora/Autoloader/autoload.php';
require_once 'Composer/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Composer/autoload.php',
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Contracts/Service/autoload.php',
	'/usr/share/php/Symfony/Component/EventDispatcher/autoload.php',
	'/usr/share/php/Symfony/Component/Finder/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/autoload.php',
	'/usr/share/php/Symfony/Component/Yaml/autoload.php',
]);

\Composer\InstalledVersions::reload(
	require __DIR__.'/installed.php'
);

$composerLoader = new \Composer\Autoload\ClassLoader('/usr/share/php');
$composerLoader->register();
