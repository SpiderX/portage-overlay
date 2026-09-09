<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Jose\\Component\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Brick/Math/autoload.php',
	'/usr/share/php/Psr/Clock/autoload.php',
	'/usr/share/php/SpomkyLabs/Pki/autoload.php',
]);
