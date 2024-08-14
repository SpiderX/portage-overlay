<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Messenger\\Bridge\\Amqp\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required([
    '/usr/share/php/Symfony/Component/Messenger/autoload.php',
]);
