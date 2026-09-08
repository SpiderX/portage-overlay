<?php

declare(strict_types=1);

$lock = json_decode(
    file_get_contents('composer.lock'),
    true,
    512,
    JSON_THROW_ON_ERROR
);

$packages = [];

foreach (array_merge($lock['packages'] ?? [], $lock['packages-dev'] ?? []) as $package) {
    $packages[] = [
        'name' => $package['name'],
        'version' => $package['version'],
        'version_normalized' => $package['version_normalized'] ?? $package['version'],
        'source' => $package['source'] ?? null,
        'dist' => $package['dist'] ?? null,
        'require' => $package['require'] ?? new stdClass(),
        'type' => $package['type'] ?? 'library',
        'installation-source' => isset($package['dist']) ? 'dist' : 'source',
        'autoload' => $package['autoload'] ?? new stdClass(),
        'notification-url' => $package['notification-url'] ?? null,
        'license' => $package['license'] ?? [],
        'authors' => $package['authors'] ?? [],
        'description' => $package['description'] ?? null,
        'homepage' => $package['homepage'] ?? null,
        'keywords' => $package['keywords'] ?? [],
        'install-path' => '../' . $package['name'],
    ];
}

file_put_contents(
    'installed.json',
    json_encode(
        [
            'packages' => $packages,
            'dev' => true,
            'dev-package-names' => array_column($lock['packages-dev'] ?? [], 'name'),
        ],
        JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES
    ) . PHP_EOL
);
