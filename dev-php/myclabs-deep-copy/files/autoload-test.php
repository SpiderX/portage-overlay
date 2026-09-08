<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('DeepCopyTest\\', 'tests/DeepCopyTest/');
Fedora\Autoloader\Autoload::addPsr4('DeepCopy\\', 'fixtures/');

\Fedora\Autoloader\Dependencies::required([
	'src/DeepCopy/autoload.php',
	'/usr/share/php/Doctrine/Common/Collections/autoload.php',
	'/usr/share/php/Doctrine/Common/autoload.php',
	'/usr/share/php/Doctrine/Persistence/autoload.php',
	'/usr/share/php/phpspec/Prophecy/autoload.php',
	'/usr/share/php/phpspec/Prophecy/PhpUnit/autoload.php',
]);
