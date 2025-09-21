# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//doctrine-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Doctrine Annotations"
HOMEPAGE="https://github.com/doctrine/annotations"
SRC_URI="https://github.com/doctrine/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[tokenizer]
	dev-php/doctrine-lexer
	dev-php/fedora-autoloader
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-common
		dev-php/phpunit
		dev-php/symfony-cache )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		lib/Doctrine/Common/Annotations/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
	# remove test uses deprecated method withConsecutive
	rm tests/Doctrine/Tests/Common/Annotations/PsrCachedReaderTest.php \
		|| die "rm failed for PsrCachedReaderTest.php"
	# exception annotation deprecated, remove override
	sed -i  -e '/testAnnotationEnumInvalidTypeDeclarationException/,+17d' \
		-e '/testAnnotationEnumInvalidLiteralDeclarationException/,+20d' \
		-e '/testAnnotationWithInvalidTargetDeclarationError/,+27d' \
		-e '/testAnnotationWithTargetEmptyError/,+25d' \
		-e '/function expectExceptionMessageMatches/,+7d' \
		tests/Doctrine/Tests/Common/Annotations/DocParserTest.php
	# fix abstract class with Test suffix
	mv tests/Doctrine/Tests/Common/Annotations/AbstractReaderTest{,X}.php \
		|| die "mv failed for AbstractReaderTest.php"
	sed -i '/abstract class/s|AbstractReaderTest|AbstractReaderTestX|' \
		tests/Doctrine/Tests/Common/Annotations/AbstractReaderTestX.php \
		|| die "sed failed for AbstractReaderTestX.php"
	sed -i '/extends/s|$|X|' tests/Doctrine/Tests/Common/Annotations/AnnotationReaderTest.php \
		|| die "sed failed for AnnotationReaderTest.php"
	# fix non-static data provider deprecation
	sed -i '/provideEnumProperties(/s|function|static function|' \
		tests/Doctrine/Tests/Common/Annotations/AnnotationReaderTest.php \
		|| die "sed failed for AnnotationReaderTest.php"
	sed -i  -e '/getAnnotationVarTypeProviderValid(/s|function|static function|g' \
		-e '/getAnnotationVarTypeProviderInvalid(/s|function|static function|g' \
		-e '/getAnnotationVarTypeArrayProviderInvalid(/s|function|static function|g' \
		-e '/getConstantsProvider(/s|function|static function|g' \
		-e '/provideTestIgnoreWholeNamespaces(/s|function|static function|g' \
		tests/Doctrine/Tests/Common/Annotations/DocParserTest.php \
		|| die "sed failed for DocParserTest.php"
	# skipped — testMultiByteAnnotation
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php
	doins -r lib/.
}
