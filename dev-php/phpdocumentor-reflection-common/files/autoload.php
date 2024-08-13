<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'phpdocumentor\\reflection\\element' => '/../Element.php',
                'phpdocumentor\\reflection\\file' => '/../File.php',
                'phpdocumentor\\reflection\\fqsen' => '/../Fqsen.php',
                'phpdocumentor\\reflection\\location' => '/../Location.php',
                'phpdocumentor\\reflection\\project' => '/../Project.php',
                'phpdocumentor\\reflection\\projectfactory' => '/../ProjectFactory.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd
