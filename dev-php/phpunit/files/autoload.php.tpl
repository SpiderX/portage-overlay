<?php

require_once 'Fedora/Autoloader/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
	___CLASSLIST___,
    ),
    __DIR__
);

\Fedora\Autoloader\Dependencies::required([
	__DIR__ . '/Framework/Assert/Functions.php',
	'/usr/share/php/myclabs/DeepCopy/autoload.php',
	'/usr/share/php/PharIo/Manifest/autoload.php',
	'/usr/share/php/PharIo/Version/autoload.php',
	'/usr/share/php/SebastianBergmann/CliParser/autoload.php',
	'/usr/share/php/SebastianBergmann/CodeCoverage/autoload.php',
	'/usr/share/php/SebastianBergmann/CodeUnit/autoload.php',
	'/usr/share/php/SebastianBergmann/Comparator/autoload.php',
	'/usr/share/php/SebastianBergmann/Diff/autoload.php',
	'/usr/share/php/SebastianBergmann/Environment/autoload.php',
	'/usr/share/php/SebastianBergmann/Exporter/autoload.php',
	'/usr/share/php/SebastianBergmann/FileIterator/autoload.php',
	'/usr/share/php/SebastianBergmann/GlobalState/autoload.php',
	'/usr/share/php/SebastianBergmann/Invoker/autoload.php',
	'/usr/share/php/SebastianBergmann/ObjectEnumerator/autoload.php',
	'/usr/share/php/SebastianBergmann/RecursionContext/autoload.php',
	'/usr/share/php/SebastianBergmann/Template/autoload.php',
	'/usr/share/php/SebastianBergmann/Timer/autoload.php',
	'/usr/share/php/SebastianBergmann/Type/autoload.php',
	'/usr/share/php/SebastianBergmann/Version/autoload.php',
]);
