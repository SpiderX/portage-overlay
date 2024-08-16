<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'sebastianbergmann\\phpcov\\application' => '/cli/Application.php',
                'sebastianbergmann\\phpcov\\arguments' => '/cli/Arguments.php',
                'sebastianbergmann\\phpcov\\argumentsbuilder' => '/cli/ArgumentsBuilder.php',
                'sebastianbergmann\\phpcov\\argumentsbuilderexception' => '/exceptions/ArgumentsBuilderException.php',
                'sebastianbergmann\\phpcov\\command' => '/cli/Command.php',
                'sebastianbergmann\\phpcov\\exception' => '/exceptions/Exception.php',
                'sebastianbergmann\\phpcov\\executecommand' => '/cli/ExecuteCommand.php',
                'sebastianbergmann\\phpcov\\helpcommand' => '/cli/HelpCommand.php',
                'sebastianbergmann\\phpcov\\mergecommand' => '/cli/MergeCommand.php',
                'sebastianbergmann\\phpcov\\patchcoverage' => '/PatchCoverage.php',
                'sebastianbergmann\\phpcov\\patchcoveragecommand' => '/cli/PatchCoverageCommand.php',
                'sebastianbergmann\\phpcov\\requiredargumentmissingexception' => '/exceptions/RequiredArgumentMissingException.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd


\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/PHPUnit/vendor/autoload.php',
	'/usr/share/php/SebastianBergmann/CodeCoverage/autoload.php',
	'/usr/share/php/SebastianBergmann/FileIterator/autoload.php',
	'/usr/share/php/SebastianBergmann/CliParser/autoload.php',
	'/usr/share/php/SebastianBergmann/Diff/autoload.php',
	'/usr/share/php/SebastianBergmann/Version/autoload.php',
]);
