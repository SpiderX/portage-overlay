<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'amp\\http\\hpack' => '/../HPack.php',
                'amp\\http\\hpackexception' => '/../HPackException.php',
                'amp\\http\\internal\\hpacknative' => '/HPackNative.php',
                'amp\\http\\internal\\hpacknghttp2' => '/HPackNghttp2.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd
