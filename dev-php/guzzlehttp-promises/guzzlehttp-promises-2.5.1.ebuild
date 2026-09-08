# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="GuzzleHttp/Promise"

inherit composer

DESCRIPTION="Guzzle Promises library for PHP with synchronous support"
HOMEPAGE="https://github.com/guzzle/promises"
SRC_URI="https://github.com/guzzle/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.5.1-tests-CoroutineTest.patch
	"${FILESDIR}/${PN}"-2.5.1-tests-UtilsTest.patch )
composer_enable_tests phpunit
