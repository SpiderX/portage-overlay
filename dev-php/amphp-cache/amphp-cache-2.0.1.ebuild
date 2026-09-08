# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Cache"

inherit composer

DESCRIPTION="A fiber-aware cache API"
HOMEPAGE="https://github.com/amphp/cache"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-serialization
	dev-php/amphp-sync
	dev-php/revolt-event-loop"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.0.1-tests-AtomicCacheTest.patch
	"${FILESDIR}/${PN}"-2.0.1-tests-SerializedCacheTest.patch
	"${FILESDIR}/${PN}"-2.0.1-tests-phpunit.xml.patch )
composer_enable_tests phpunit
