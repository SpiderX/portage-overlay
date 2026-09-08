# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="League/Flysystem"
PHP_REQ_USE="fileinfo?,ftp?,zip?"

inherit composer

DESCRIPTION="Abstraction for local and remote filesystems"
HOMEPAGE="https://github.com/thephpleague/flysystem"
SRC_URI="https://github.com/thephpleague/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fileinfo ftp zip"
REQUIRED_USE="test? ( fileinfo ftp zip )"

RDEPEND="dev-php/league-flysystem-local
	dev-php/league-mime-type-detection"
BDEPEND="test? ( dev-php/guzzlehttp-psr7 )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.35.2-tests-ConfigTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-DirectoryAttributesTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-DirectoryListingTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-ExceptionInformationTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-FileAttributesTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-FilesystemTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-InMemoryFilesystemAdapterTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-MountManagerTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-PathPrefixerTest.patch
	"${FILESDIR}/${PN}"-3.35.2-tests-WhitespacePathNormalizerTest.patch )
composer_enable_tests phpunit

src_test() {
	edo composer create-project -q --no-install --prefer-source "${COMPOSER_PN}:${PV}" "${COMPOSER_SRC}"
	edo cp -r "${COMPOSER_SRC}"/{phpunit.xml.dist,phpunit.php,test_files,mocked-functions.php} "${S}"
	edo cp -r "${COMPOSER_SRC}"/src/{AdapterTestUtilities,InMemory,*Test.php} "${S}"/src
	composer_test_patch
	ephpunit
	# clean up test files before install
	edo rm -rf src/{AdapterTestUtilities,InMemory,*Test.php}
}
