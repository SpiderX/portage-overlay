# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Nyholm/Psr7"

inherit composer

DESCRIPTION="A super lightweight PSR-7 implementation"
HOMEPAGE="https://github.com/Nyholm/psr7"
SRC_URI="https://github.com/Nyholm/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-http-factory
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests
		dev-php/php-http-message-factory
		dev-php/php-http-psr7-integration-tests )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.8.2-tests-RequestTest.patch
	"${FILESDIR}/${PN}"-1.8.2-tests-ResponseTest.patch
	"${FILESDIR}/${PN}"-1.8.2-tests-UploadedFileTest.patch
	"${FILESDIR}/${PN}"-1.8.2-tests-UriTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo mkdir -p vendor/http-interop/http-factory-tests
	edo ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test
	ephpunit
}
