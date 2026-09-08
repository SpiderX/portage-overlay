<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	___CLASSLIST___,
    ),
    __DIR__
);

\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/nikic/PhpParser/autoload.php',
	'/usr/share/php/SebastianBergmann/Complexity/autoload.php',
	'/usr/share/php/SebastianBergmann/Environment/autoload.php',
	'/usr/share/php/SebastianBergmann/LinesOfCode/autoload.php',
	'/usr/share/php/SebastianBergmann/Template/autoload.php',
	'/usr/share/php/SebastianBergmann/Version/autoload.php',
	'/usr/share/php/TheSeer/Tokenizer/autoload.php',
]);
