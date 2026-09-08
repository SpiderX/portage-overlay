# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Http/Server"
PHP_REQ_USE="ipv6?"

inherit composer

DESCRIPTION="An advanced async HTTP server library for PHP"
HOMEPAGE="https://github.com/amphp/http-server"
SRC_URI="https://github.com/amphp/${COMPOSER_PKGN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-hpack
	dev-php/amphp-http
	dev-php/amphp-pipeline
	dev-php/amphp-socket
	dev-php/amphp-sync
	dev-php/league-uri
	dev-php/league-uri-interfaces
	dev-php/psr-http-message
	dev-php/psr-log
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/amphp-http-client )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.4.6-tests-ForwardedMiddlewareTest.patch
	"${FILESDIR}/${PN}"-3.4.6-tests-Http1DriverTest.patch
	"${FILESDIR}/${PN}"-3.4.6-tests-Http2DriverTest.patch
	"${FILESDIR}/${PN}"-3.4.6-tests-phpunit.xml.patch )
composer_enable_tests phpunit

src_test() {
	use ipv6 || COMPOSER_TEST_PATCHES+=( "${FILESDIR}/${PN}"-3.4.6-tests-no-ipv6.patch )
	composer_prepare_tests
	ephpunit
}
