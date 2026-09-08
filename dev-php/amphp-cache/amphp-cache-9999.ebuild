# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Cache"

inherit composer git-r3

DESCRIPTION="A fiber-aware cache API"
HOMEPAGE="https://github.com/amphp/cache"
EGIT_REPO_URI="https://github.com/amphp/cache.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-serialization
	dev-php/amphp-sync
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-2.0.1-tests-AtomicCacheTest.patch
	"${FILESDIR}/${PN}"-2.0.1-tests-phpunit.xml.patch
	"${FILESDIR}/${PN}"-2.0.1-tests-SerializedCacheTest.patch )
