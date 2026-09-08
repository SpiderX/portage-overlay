# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Amp/Http/Client"

inherit composer optfeature

DESCRIPTION="Advanced async HTTP client library for PHP"
HOMEPAGE="https://github.com/amphp/http-client"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-hpack
	dev-php/amphp-http
	dev-php/amphp-pipeline
	dev-php/amphp-socket
	dev-php/amphp-sync
	dev-php/league-uri
	dev-php/league-uri-components
	dev-php/league-uri-interfaces
	dev-php/psr-http-message
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/amphp-file
		dev-php/amphp-http-server
		dev-php/laminas-diactoros )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-5.3.6-tests-ClientHttpBinIntegrationTest.patch
	"${FILESDIR}/${PN}"-5.3.6-tests-FollowRedirectsTest.patch
	"${FILESDIR}/${PN}"-5.3.6-tests-Http1ConnectionTest.patch
	"${FILESDIR}/${PN}"-5.3.6-tests-Http2ConnectionTest.patch
	"${FILESDIR}/${PN}"-5.3.6-tests-phpunit.xml.patch
	"${FILESDIR}/${PN}"-5.3.6-tests-RequestTest.patch
	"${FILESDIR}/${PN}"-5.3.6-tests-ResponseTest.patch )

composer_enable_tests phpunit

pkg_postinst() {
	optfeature "Support for file request bodies and HTTP archive logging" dev-php/amphp-file
}
