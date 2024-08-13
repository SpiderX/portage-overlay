<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'phpdocumentor\\reflection\\docblock' => '/../DocBlock.php',
                'phpdocumentor\\reflection\\docblock\\description' => '/Description.php',
                'phpdocumentor\\reflection\\docblock\\descriptionfactory' => '/DescriptionFactory.php',
                'phpdocumentor\\reflection\\docblock\\examplefinder' => '/ExampleFinder.php',
                'phpdocumentor\\reflection\\docblock\\serializer' => '/Serializer.php',
                'phpdocumentor\\reflection\\docblock\\standardtagfactory' => '/StandardTagFactory.php',
                'phpdocumentor\\reflection\\docblock\\tag' => '/Tag.php',
                'phpdocumentor\\reflection\\docblock\\tagfactory' => '/TagFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\author' => '/Tags/Author.php',
                'phpdocumentor\\reflection\\docblock\\tags\\basetag' => '/Tags/BaseTag.php',
                'phpdocumentor\\reflection\\docblock\\tags\\covers' => '/Tags/Covers.php',
                'phpdocumentor\\reflection\\docblock\\tags\\deprecated' => '/Tags/Deprecated.php',
                'phpdocumentor\\reflection\\docblock\\tags\\example' => '/Tags/Example.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\abstractphpstanfactory' => '/Tags/Factory/AbstractPHPStanFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\factory' => '/Tags/Factory/Factory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\methodfactory' => '/Tags/Factory/MethodFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\paramfactory' => '/Tags/Factory/ParamFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\phpstanfactory' => '/Tags/Factory/PHPStanFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\propertyfactory' => '/Tags/Factory/PropertyFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\propertyreadfactory' => '/Tags/Factory/PropertyReadFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\propertywritefactory' => '/Tags/Factory/PropertyWriteFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\returnfactory' => '/Tags/Factory/ReturnFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\staticmethod' => '/Tags/Factory/StaticMethod.php',
                'phpdocumentor\\reflection\\docblock\\tags\\factory\\varfactory' => '/Tags/Factory/VarFactory.php',
                'phpdocumentor\\reflection\\docblock\\tags\\formatter' => '/Tags/Formatter.php',
                'phpdocumentor\\reflection\\docblock\\tags\\formatter\\alignformatter' => '/Tags/Formatter/AlignFormatter.php',
                'phpdocumentor\\reflection\\docblock\\tags\\formatter\\passthroughformatter' => '/Tags/Formatter/PassthroughFormatter.php',
                'phpdocumentor\\reflection\\docblock\\tags\\generic' => '/Tags/Generic.php',
                'phpdocumentor\\reflection\\docblock\\tags\\invalidtag' => '/Tags/InvalidTag.php',
                'phpdocumentor\\reflection\\docblock\\tags\\link' => '/Tags/Link.php',
                'phpdocumentor\\reflection\\docblock\\tags\\method' => '/Tags/Method.php',
                'phpdocumentor\\reflection\\docblock\\tags\\methodparameter' => '/Tags/MethodParameter.php',
                'phpdocumentor\\reflection\\docblock\\tags\\param' => '/Tags/Param.php',
                'phpdocumentor\\reflection\\docblock\\tags\\property' => '/Tags/Property.php',
                'phpdocumentor\\reflection\\docblock\\tags\\propertyread' => '/Tags/PropertyRead.php',
                'phpdocumentor\\reflection\\docblock\\tags\\propertywrite' => '/Tags/PropertyWrite.php',
                'phpdocumentor\\reflection\\docblock\\tags\\reference\\fqsen' => '/Tags/Reference/Fqsen.php',
                'phpdocumentor\\reflection\\docblock\\tags\\reference\\reference' => '/Tags/Reference/Reference.php',
                'phpdocumentor\\reflection\\docblock\\tags\\reference\\url' => '/Tags/Reference/Url.php',
                'phpdocumentor\\reflection\\docblock\\tags\\return_' => '/Tags/Return_.php',
                'phpdocumentor\\reflection\\docblock\\tags\\see' => '/Tags/See.php',
                'phpdocumentor\\reflection\\docblock\\tags\\since' => '/Tags/Since.php',
                'phpdocumentor\\reflection\\docblock\\tags\\source' => '/Tags/Source.php',
                'phpdocumentor\\reflection\\docblock\\tags\\tagwithtype' => '/Tags/TagWithType.php',
                'phpdocumentor\\reflection\\docblock\\tags\\throws' => '/Tags/Throws.php',
                'phpdocumentor\\reflection\\docblock\\tags\\uses' => '/Tags/Uses.php',
                'phpdocumentor\\reflection\\docblock\\tags\\var_' => '/Tags/Var_.php',
                'phpdocumentor\\reflection\\docblock\\tags\\version' => '/Tags/Version.php',
                'phpdocumentor\\reflection\\docblockfactory' => '/../DocBlockFactory.php',
                'phpdocumentor\\reflection\\docblockfactoryinterface' => '/../DocBlockFactoryInterface.php',
                'phpdocumentor\\reflection\\exception\\pcreexception' => '/../Exception/PcreException.php',
                'phpdocumentor\\reflection\\utils' => '/../Utils.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd

// Dependencies
\Fedora\Autoloader\Dependencies::required([
    '/usr/share/php/Reflection/TypeResolver/autoload.php',
    '/usr/share/php/Webmozart/Assert/autoload.php',
    '/usr/share/php/phpDocumentor/Reflection/Common/autoload.php',
    '/usr/share/php/PHPStan/PhpDocParser/autoload.php',
    '/usr/share/php/Doctrine/Deprecations/autoload.php',
]);
