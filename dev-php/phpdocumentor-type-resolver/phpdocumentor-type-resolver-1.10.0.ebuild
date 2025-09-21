# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="TypeResolver"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="phpDocumentor TypeResolver component"
HOMEPAGE="https://github.com/phpDocumentor/TypeResolver"
SRC_URI="https://github.com/phpDocumentor/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[tokenizer]
	dev-php/doctrine-deprecations
	dev-php/fedora-autoloader
	dev-php/phpdocumentor-reflection-common
	dev-php/phpstan-phpdoc-parser"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/TypeResolver/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
	# fix non-static data provider deprecation
	sed -i '/provideArrays(/s|function|static function|' \
		tests/unit/PseudoTypes/{IntRange,List,NonEmptyArray,NonEmptyList}Test.php \
		tests/unit/Types/ArrayTest.php \
		|| die "sed failed for provideArrays"
	sed -i  -e '/provideKeywords(/s|function|static function|' \
		-e '/provideClassStrings(/s|function|static function|' \
		-e '/provideInterfaceStrings(/s|function|static function|' \
		-e '/provideFqcn(/s|function|static function|' \
		-e '/typeProvider(/s|function|static function|' \
		-e '/genericsProvider(/s|function|static function|' \
		-e '/callableProvider(/s|function|static function|' \
		-e '/constExpressions(/s|function|static function|' \
		-e '/shapeStructures(/s|function|static function|' \
		-e '/illegalLegacyFormatProvider(/s|function|static function|' \
		tests/unit/TypeResolverTest.php \
		|| die "sed failed for TypeResolverTest.php"
	sed -i '/provideClassStrings(/s|function|static function|' \
		tests/unit/Types/ClassStringTest.php \
		|| die "sed failed for ClassStringTest.php"
	sed -i '/provideCollections(/s|function|static function|' \
		tests/unit/Types/CollectionTest.php \
		|| die "sed failed for CollectionTest.php"
	sed -i '/provideInterfaceStrings(/s|function|static function|' \
		tests/unit/Types/InterfaceStringTest.php \
		|| die "sed failed for InterfaceStringTest.php"
	sed -i '/provideIterables(/s|function|static function|' \
		tests/unit/Types/IterableTest.php \
		|| die "sed failed for IterableTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/phpDocumentor/Reflection
	doins -r src/.
}
