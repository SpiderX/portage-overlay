<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'psr\\http\\message\\requestfactoryinterface' => '/../RequestFactoryInterface.php',
                'psr\\http\\message\\responsefactoryinterface' => '/../ResponseFactoryInterface.php',
                'psr\\http\\message\\serverrequestfactoryinterface' => '/../ServerRequestFactoryInterface.php',
                'psr\\http\\message\\streamfactoryinterface' => '/../StreamFactoryInterface.php',
                'psr\\http\\message\\uploadedfilefactoryinterface' => '/../UploadedFileFactoryInterface.php',
                'psr\\http\\message\\urifactoryinterface' => '/../UriFactoryInterface.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
