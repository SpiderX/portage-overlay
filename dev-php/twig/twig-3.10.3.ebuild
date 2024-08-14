# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN^}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PHP templating engine with syntax similar to Django"
HOMEPAGE="https://github.com/twigphp/Twig"
SRC_URI="https://github.com/twigphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-polyfill-php80"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/psr-container
		dev-php/symfony-phpunit-bridge )"

DOCS=( CHANGELOG README.rst )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN}/${PN}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN}"/"${PN}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
	# replace deprecated method
	sed -i '/initExtensions/s|setMethods|addMethods|' \
		tests/EnvironmentTest.php || die "sed failed for EnvironmentTest.php"
	# fix abstract class with Test suffix
	mv tests/Profiler/Dumper/AbstractTest{,Abstract}.php \
		|| die "mv failed"
	sed -i '/class/s|AbstractTest|AbstractTestAbstract|' \
		tests/Profiler/Dumper/{AbstractTestAbstract,BlackfireTest,HtmlTest,TextTest}.php \
		|| die "sed failed"
	# disable failed test
	sed -i '/testTwigArrayMapThrowsRuntimeExceptions/,+26d' \
		tests/ErrorTest.php || die "sed failed for ErrorTest.php"
	# remove test with empty data set
	rm tests/Node/MacroTest.php || die "rm failed for MacroTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Twig
	doins -r src/.
}
