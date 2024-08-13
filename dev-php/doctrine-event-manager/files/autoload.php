<?php

require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'doctrine\\common\\eventargs' => '/../EventArgs.php',
        'doctrine\\common\\eventmanager' => '/../EventManager.php',
        'doctrine\\common\\eventsubscriber' => '/../EventSubscriber.php',
    ),
    __DIR__
);
