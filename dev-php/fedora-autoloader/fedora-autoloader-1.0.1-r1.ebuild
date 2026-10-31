# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Fedora/Autoloader"

inherit composer

DESCRIPTION="Fedora's Static PSR-4, PSR-0, and classmap autoloader"
HOMEPAGE="https://github.com/php-fedora/autoloader"
SRC_URI="https://github.com/php-fedora/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.0.1-tests-DependenciesTest.patch
	"${FILESDIR}/${PN}"-1.0.1-tests-FunctionsTest.patch )

composer_enable_tests phpunit
