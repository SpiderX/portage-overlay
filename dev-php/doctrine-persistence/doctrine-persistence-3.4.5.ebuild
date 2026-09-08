# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine"

inherit composer

DESCRIPTION="Doctrine Persistence"
HOMEPAGE="https://github.com/doctrine/persistence"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-event-manager
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/doctrine-common
		dev-php/symfony-cache )"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_FILES=( tests_php74 tests_php81 )
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.4.5-tests-AbstractClassMetadataFactoryTest.patch
	"${FILESDIR}/${PN}"-3.4.5-tests-ColocatedMappingDriverTest.patch
	"${FILESDIR}/${PN}"-3.4.5-tests-DriverChainTest.patch
	"${FILESDIR}/${PN}"-3.4.5-tests-FileDriverTest.patch
	"${FILESDIR}/${PN}"-3.4.5-tests-ManagerRegistryTest.patch
	"${FILESDIR}/${PN}"-3.4.5-tests-RuntimeReflectionPropertyTest.patch
	"${FILESDIR}/${PN}"-3.4.5-tests-SymfonyFileLocatorTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir src/Persistence
	edo phpab -q -o src/Persistence/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
