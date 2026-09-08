# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="League/MimeTypeDetection"
PHP_REQ_USE="fileinfo"

inherit composer

DESCRIPTION="League Mime Type Detection"
HOMEPAGE="https://github.com/thephpleague/mime-type-detection"
SRC_URI="https://github.com/thephpleague/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.17.0-tests-EmptyExtensionToMimeTypeMapTest.patch
	"${FILESDIR}/${PN}"-1.17.0-tests-ExtensionMimeTypeDetectorTest.patch
	"${FILESDIR}/${PN}"-1.17.0-tests-FinfoMimeTypeDetectorTest.patch
	"${FILESDIR}/${PN}"-1.17.0-tests-GeneratedExtensionToMimeTypeMapTest.patch
	"${FILESDIR}/${PN}"-1.17.0-tests-OverridingExtensionToMimeTypeMapTest.patch )
composer_enable_tests phpunit

src_test() {
	edo composer create-project -q --no-install --prefer-source "${COMPOSER_PN}:${PV}" "${COMPOSER_SRC}"
	edo cp -r "${COMPOSER_SRC}"/{phpunit.xml.dist,test_files} "${S}"
	edo cp -r "${COMPOSER_SRC}"/src/{Generation,*Test.php} "${S}"/src
	composer_test_patch
	ephpunit
	# clean up test files before install
	edo rm -rf src/{Generation,*Test.php}
}
