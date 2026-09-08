# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Serialization"

inherit composer

DESCRIPTION="Serialization tools for IPC and data storage in PHP"
HOMEPAGE="https://github.com/amphp/serialization"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.0.0-tests-JsonSerializerTest.patch
	"${FILESDIR}/${PN}"-1.0.0-tests-NativeSerializerTest.patch )
composer_enable_tests phpunit
