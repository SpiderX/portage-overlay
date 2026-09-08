# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/DeepCopy"
COMPOSER_INSTALL_PATH="myclabs"

inherit composer

DESCRIPTION="Create deep copies (clones) of your objects"
HOMEPAGE="https://github.com/myclabs/deepcopy"
SRC_URI="https://github.com/myclabs/${COMPOSER_PKG/-/}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/DeepCopy-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!dev-php/myclabs-deepcopy"
BDEPEND="test? ( dev-php/doctrine-collections
		dev-php/doctrine-common
		dev-php/doctrine-persistence
		dev-php/phpspec-prophecy
		dev-php/phpspec-prophecy-phpunit )"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_FILES=( fixtures )
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.13.4-tests-ArrayObjectFilterTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-DeepCopyTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-DoctrineProxyMatcherTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-PropertyMatcherTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-PropertyNameMatcherTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-PropertyTypeMatcherTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-ReflectionHelperTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-ReplaceFilterTest.patch
	"${FILESDIR}/${PN}"-1.13.4-tests-TypeMatcherTest.patch )
composer_enable_tests phpunit
