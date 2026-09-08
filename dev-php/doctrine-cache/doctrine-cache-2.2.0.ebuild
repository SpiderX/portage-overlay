# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="lib/Doctrine/Common/Cache"
COMPOSER_INSTALL_PATH=""
COMPOSER_INSTALL_SRC="lib"

inherit composer

DESCRIPTION="Doctrine Cache"
HOMEPAGE="https://github.com/doctrine/cache"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/cache-integration-tests
		dev-php/psr-cache
		dev-php/symfony-cache
		dev-php/symfony-var-exporter )"

PATCHES=( "${FILESDIR}/${PN}"-2.2.0-src-CacheAdapter.patch )

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.2.0-tests-CacheAdapterTest.patch
	"${FILESDIR}/${PN}"-2.2.0-tests-CacheProviderTest.patch
	"${FILESDIR}/${PN}"-2.2.0-tests-CacheTest.patch
	"${FILESDIR}/${PN}"-2.2.0-tests-phpunit.xml.patch )
composer_enable_tests phpunit
