<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Composer/autoload.php',
	'/usr/share/php/Doctrine/Deprecations/autoload.php',
	'/usr/share/php/Psr/Cache/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Contracts/HttpClient/autoload.php',
	'/usr/share/php/Symfony/Contracts/Translation/autoload.php',
	'/usr/share/php/Symfony/Component/BrowserKit/autoload.php',
	'/usr/share/php/Symfony/Component/Clock/autoload.php',
	'/usr/share/php/Symfony/Component/Config/autoload.php',
	'/usr/share/php/Symfony/Component/Console/autoload.php',
	'/usr/share/php/Symfony/Component/CssSelector/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/DomCrawler/autoload.php',
	'/usr/share/php/Symfony/Component/ExpressionLanguage/autoload.php',
	'/usr/share/php/Symfony/Component/Finder/autoload.php',
	'/usr/share/php/Symfony/Component/Process/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Component/Routing/autoload.php',
	'/usr/share/php/Symfony/Component/Serializer/autoload.php',
	'/usr/share/php/Symfony/Component/Stopwatch/autoload.php',
	'/usr/share/php/Symfony/Component/Translation/autoload.php',
	'/usr/share/php/Symfony/Component/Validator/autoload.php',
	'/usr/share/php/Symfony/Component/VarDumper/autoload.php',
	'/usr/share/php/Symfony/Component/VarExporter/autoload.php',
	'/usr/share/php/Symfony/Component/Uid/autoload.php',
	'/usr/share/php/Twig/autoload.php',
]);

\Composer\InstalledVersions::reload(
	require __DIR__.'/installed.php'
);
