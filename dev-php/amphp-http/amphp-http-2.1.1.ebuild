# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTTP primitives which can be shared by servers and clients"
HOMEPAGE="https://github.com/amphp/http"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/amphp-hpack
	dev-php/amphp-parser
	dev-php/fedora-autoloader
	dev-php/league-uri-components
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test} "${S}" \
		|| die "cp failed"
	# fix abstract class with Test suffix
	mv test/HeaderParsingTest{,Abstract}.php || die "mv failed"
	sed -i '/class /s|HeaderParsingTest|HeaderParsingTestAbstract|' \
		test/HeaderParsingTestAbstract.php test/SplitHeaderTest.php \
		test/ParseHeaderFieldsTest.php || die "sed failed"
	# php.ini must have zend.assertions = 1
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Http
	doins -r src/.
}
