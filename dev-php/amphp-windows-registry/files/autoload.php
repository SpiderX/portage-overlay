<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Amp\\WindowsRegistry\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Amp/ByteStream/autoload.php',
	'/usr/share/php/Amp/Process/autoload.php',
]);
