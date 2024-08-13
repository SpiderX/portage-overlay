<?php
// @codingStandardsIgnoreFile
// @codeCoverageIgnoreStart
require_once 'Fedora/Autoloader'.'/autoload.php';

\Fedora\Autoloader\Autoload::addClassMap(
    array(
        'league\\uri\\contracts\\authorityinterface' => '/../Contracts/AuthorityInterface.php',
                'league\\uri\\contracts\\datapathinterface' => '/../Contracts/DataPathInterface.php',
                'league\\uri\\contracts\\domainhostinterface' => '/../Contracts/DomainHostInterface.php',
                'league\\uri\\contracts\\fragmentinterface' => '/../Contracts/FragmentInterface.php',
                'league\\uri\\contracts\\hostinterface' => '/../Contracts/HostInterface.php',
                'league\\uri\\contracts\\iphostinterface' => '/../Contracts/IpHostInterface.php',
                'league\\uri\\contracts\\pathinterface' => '/../Contracts/PathInterface.php',
                'league\\uri\\contracts\\portinterface' => '/../Contracts/PortInterface.php',
                'league\\uri\\contracts\\queryinterface' => '/../Contracts/QueryInterface.php',
                'league\\uri\\contracts\\segmentedpathinterface' => '/../Contracts/SegmentedPathInterface.php',
                'league\\uri\\contracts\\uriaccess' => '/../Contracts/UriAccess.php',
                'league\\uri\\contracts\\uricomponentinterface' => '/../Contracts/UriComponentInterface.php',
                'league\\uri\\contracts\\uriexception' => '/../Contracts/UriException.php',
                'league\\uri\\contracts\\uriinterface' => '/../Contracts/UriInterface.php',
                'league\\uri\\contracts\\userinfointerface' => '/../Contracts/UserInfoInterface.php',
                'league\\uri\\encoder' => '/../Encoder.php',
                'league\\uri\\exceptions\\conversionfailed' => '/../Exceptions/ConversionFailed.php',
                'league\\uri\\exceptions\\missingfeature' => '/../Exceptions/MissingFeature.php',
                'league\\uri\\exceptions\\offsetoutofbounds' => '/../Exceptions/OffsetOutOfBounds.php',
                'league\\uri\\exceptions\\syntaxerror' => '/../Exceptions/SyntaxError.php',
                'league\\uri\\featuredetection' => '/../FeatureDetection.php',
                'league\\uri\\idna\\converter' => '/../Idna/Converter.php',
                'league\\uri\\idna\\error' => '/../Idna/Error.php',
                'league\\uri\\idna\\option' => '/../Idna/Option.php',
                'league\\uri\\idna\\result' => '/../Idna/Result.php',
                'league\\uri\\ipv4\\bcmathcalculator' => '/../IPv4/BCMathCalculator.php',
                'league\\uri\\ipv4\\calculator' => '/../IPv4/Calculator.php',
                'league\\uri\\ipv4\\converter' => '/../IPv4/Converter.php',
                'league\\uri\\ipv4\\gmpcalculator' => '/../IPv4/GMPCalculator.php',
                'league\\uri\\ipv4\\nativecalculator' => '/../IPv4/NativeCalculator.php',
                'league\\uri\\keyvaluepair\\converter' => '/../KeyValuePair/Converter.php',
                'league\\uri\\querystring' => '/../QueryString.php',
                'league\\uri\\uristring' => '/../UriString.php',
    ),
    __DIR__
);
// @codeCoverageIgnoreEnd

// Dependencies
\Fedora\Autoloader\Dependencies::required([
	'/usr/share/php/Psr/Http/Message/autoload.php',
	'/usr/share/php/Psr/Http/Message/Factory/autoload.php',
]);
