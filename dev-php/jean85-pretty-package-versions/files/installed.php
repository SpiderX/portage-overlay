<?php

return [
    'root' => [
        'name' => 'jean85/pretty-package-versions',
        'pretty_version' => '2.1.1',
        'version' => '2.1.1.0',
        'reference' => null,
        'type' => 'library',
        'install_path' => dirname(__DIR__),
        'aliases' => [],
        'dev' => true,
    ],
    'versions' => [
        'jean85/pretty-package-versions' => [
            'pretty_version' => '2.1.1',
            'version' => '2.1.1.0',
            'reference' => null,
            'type' => 'library',
            'install_path' => dirname(__DIR__),
            'aliases' => [],
            'dev_requirement' => false,
        ],
        'psr/log-implementation' => [
            'pretty_version' => null,
            'version' => null,
            'reference' => null,
            'type' => null,
            'install_path' => null,
            'aliases' => [],
            'provided' => [
                '*',
            ],
            'dev_requirement' => false,
        ],
        'monolog/monolog' => [
            'pretty_version' => null,
            'version' => null,
            'reference' => null,
            'type' => null,
            'install_path' => null,
            'aliases' => [],
            'replaced' => [
                '*',
            ],
            'dev_requirement' => false,
        ],
        'phpunit/phpunit' => [
            'pretty_version' => '12.5.30',
            'version' => '12.5.30.0',
            'reference' => '',
            'type' => 'library',
            'install_path' => null,
            'aliases' => [],
            'dev_requirement' => false,
        ],
    ],
];
