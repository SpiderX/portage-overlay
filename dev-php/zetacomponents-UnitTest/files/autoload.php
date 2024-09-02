<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
// this is an autogenerated file - do not edit
spl_autoload_register(
    function($class) {
        static $classes = null;
        if ($classes === null) {
            $classes = array(
                'ezctestcase' => '/test/case.php',
                'ezctestconstraintsimilarimage' => '/constraint/image.php',
                'ezctestimagecase' => '/test/image_case.php',
                'ezctestregressionsuite' => '/regression_suite.php',
                'ezctestregressiontest' => '/regression_test.php'
            );
        }
        $cn = strtolower($class);
        if (isset($classes[$cn])) {
            require __DIR__ . $classes[$cn];
        }
    },
    true,
    false
);
// @codeCoverageIgnoreEnd