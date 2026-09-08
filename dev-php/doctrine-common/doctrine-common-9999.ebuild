# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine"

inherit composer git-r3

DESCRIPTION="Doctrine Common"
HOMEPAGE="https://github.com/doctrine/common"
EGIT_REPO_URI="https://github.com/doctrine/common.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/doctrine-persistence"

PATCHES=( "${FILESDIR}/${PN}"-3.5.0-tests-ProxyMagicMethodsTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyGeneratorTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-DebugTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ClassUtilsTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-AutoloaderTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicVoidReturnTypeTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicTypedPropertiesTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicIdentifierGetterTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-ProxyLogicTest.patch
	"${FILESDIR}/${PN}"-3.5.0-tests-AbstractProxyFactoryTest.patch )

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir src/Common
	edo phpab -q -o src/Common/autoload.php -t "${FILESDIR}"/autoload.php.tpl src

	# PHPUnit expects class DoctrineExceptionTest, but file is empty
	edo rm tests/Common/DoctrineExceptionTest.php
}
