# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="GuzzleHttp/Psr7"

inherit composer

DESCRIPTION="PSR-7 HTTP message library"
HOMEPAGE="https://github.com/guzzle/psr7"
SRC_URI="https://github.com/guzzle/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-http-factory
	dev-php/psr-http-message
	dev-php/ralouphie-getallheaders"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests
		dev-php/symfony-deprecation-contracts )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.12.5-tests-AppendStreamTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-FnStreamTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-HeaderTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-MessageTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-MultipartStreamTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-PumpStreamTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-QueryTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-RequestTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-ResponseTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-ServerRequestTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-StreamDecoratorTraitTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-StreamTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-StreamWrapperTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-UploadedFileTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-UriComparatorTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-UriNormalizerTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-UriResolverTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-UriTest.patch
	"${FILESDIR}/${PN}"-2.12.5-tests-UtilsTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo mkdir -p vendor/http-interop/http-factory-tests
	edo ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test
	ephpunit
}
