# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Socket"
PHP_REQ_USE="ipv6?,ssl"

inherit composer

DESCRIPTION="Non-blocking socket and TLS functionality for PHP"
HOMEPAGE="https://github.com/amphp/socket"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-dns
	dev-php/kelunik-certificate
	dev-php/league-uri
	dev-php/league-uri-interfaces
	dev-php/revolt-event-loop"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.4.0-tests-BindContextTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-CidrMatcherTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-ClientTlsContextTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-ConnectContextTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-FunctionsTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-IntegrationTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-InternetAddressTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-PendingAcceptErrorTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-ServerTlsContextTest.patch )
composer_enable_tests phpunit

src_test() {
	use ipv6 || COMPOSER_TEST_PATCHES+=( "${FILESDIR}/${PN}"-2.4.0-tests-no-ipv6.patch )
	composer_prepare_tests
	edo pushd test/tls
	edo ./regenerate.sh
	edo popd
	ephpunit
}
