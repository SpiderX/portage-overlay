<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Dependencies::required([
	'autoload.php',
	'/usr/share/php/Composer/autoload.php',
	'/usr/share/php/Doctrine/Common/Collections/autoload.php',
	'/usr/share/php/Doctrine/Common/DataFixtures/autoload.php',
	'/usr/share/php/Doctrine/DBAL/autoload.php',
	'/usr/share/php/Doctrine/ORM/autoload.php',
	'/usr/share/php/Psr/Log/autoload.php',
	'/usr/share/php/Symfony/Bridge/PhpUnit/autoload.php',
	'/usr/share/php/Symfony/Component/Cache/autoload.php',
	'/usr/share/php/Symfony/Component/Config/autoload.php',
	'/usr/share/php/Symfony/Component/DependencyInjection/autoload.php',
	'/usr/share/php/Symfony/Component/ExpressionLanguage/autoload.php',
	'/usr/share/php/Symfony/Component/Form/autoload.php',
	'/usr/share/php/Symfony/Component/HttpKernel/autoload.php',
	'/usr/share/php/Symfony/Component/Lock/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/autoload.php',
	'/usr/share/php/Symfony/Component/Messenger/Bridge/Doctrine/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyAccess/autoload.php',
	'/usr/share/php/Symfony/Component/PropertyInfo/autoload.php',
	'/usr/share/php/Symfony/Component/Security/Core/autoload.php',
	'/usr/share/php/Symfony/Component/Stopwatch/autoload.php',
	'/usr/share/php/Symfony/Component/Translation/autoload.php',
	'/usr/share/php/Symfony/Component/TypeInfo/autoload.php',
	'/usr/share/php/Symfony/Component/Validator/autoload.php',
	'/usr/share/php/Symfony/Component/VarDumper/autoload.php',
	'/usr/share/php/Symfony/Component/Uid/autoload.php',
]);

\Composer\InstalledVersions::reload(
	require __DIR__.'/installed.php'
);
