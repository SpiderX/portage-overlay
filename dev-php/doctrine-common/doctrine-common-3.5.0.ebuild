# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine"

inherit composer

DESCRIPTION="Doctrine Common"
HOMEPAGE="https://github.com/doctrine/common"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-persistence"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyMagicMethodsTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyGeneratorTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-DebugTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ClassUtilsTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-AutoloaderTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicVoidReturnTypeTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicTypedPropertiesTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicIdentifierGetterTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-AbstractProxyFactoryTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir src/Common
	edo phpab -q -o src/Common/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}

src_test() {
	composer_prepare_tests
	# PHPUnit expects class DoctrineExceptionTest, but file is empty
	edo rm tests/Common/DoctrineExceptionTest.php
	ephpunit
}
