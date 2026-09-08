# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Internal"
COMPOSER_INSTALL_PATH="Amp/Http"

inherit composer

DESCRIPTION="HTTP/2 header compression implementation in PHP"
HOMEPAGE="https://github.com/amphp/hpack"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/http2jp-hpack-test-case
		dev-php/nikic-php-fuzzer )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.2.2-tests-phpunit.xml.patch
	"${FILESDIR}/${PN}"-3.2.2-tests-HPackTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo mkdir -p vendor/http2jp
	edo ln -s ../../../../../../../../../../usr/share/php/http2jp/hpack-test-case vendor/http2jp
	ephpunit
}
