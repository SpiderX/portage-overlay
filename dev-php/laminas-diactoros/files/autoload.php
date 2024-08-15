<?php

require_once 'Fedora/Autoloader/autoload.php';

Fedora\Autoloader\Autoload::addPsr4('Laminas\\Diactoros\\', __DIR__);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/functions/create_uploaded_file.php',
	__DIR__ . '/functions/marshal_headers_from_sapi.php',
	__DIR__ . '/functions/marshal_method_from_sapi.php',
	__DIR__ . '/functions/marshal_protocol_version_from_sapi.php',
	__DIR__ . '/functions/normalize_server.php',
	__DIR__ . '/functions/normalize_uploaded_files.php',
	__DIR__ . '/functions/parse_cookie_header.php',
	'/usr/share/php/Psr/Http/Message/Factory/autoload.php',
	'/usr/share/php/Psr/Http/Message/autoload.php',
]);
