<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'league\\uri\\components\\authority' => '/Authority.php',
                'league\\uri\\components\\component' => '/Component.php',
                'league\\uri\\components\\datapath' => '/DataPath.php',
                'league\\uri\\components\\domain' => '/Domain.php',
                'league\\uri\\components\\fragment' => '/Fragment.php',
                'league\\uri\\components\\hierarchicalpath' => '/HierarchicalPath.php',
                'league\\uri\\components\\host' => '/Host.php',
                'league\\uri\\components\\path' => '/Path.php',
                'league\\uri\\components\\port' => '/Port.php',
                'league\\uri\\components\\query' => '/Query.php',
                'league\\uri\\components\\scheme' => '/Scheme.php',
                'league\\uri\\components\\urlsearchparams' => '/URLSearchParams.php',
                'league\\uri\\components\\userinfo' => '/UserInfo.php',
                'league\\uri\\ipv4normalizer' => '/../IPv4Normalizer.php',
                'league\\uri\\modifier' => '/../Modifier.php',
                'league\\uri\\urimodifier' => '/../UriModifier.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/League/Uri/autoload.php',
]);
