# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Fedora/Autoloader"

inherit composer git-r3

DESCRIPTION="Fedora's Static PSR-4, PSR-0, and classmap autoloader"
HOMEPAGE="https://github.com/php-fedora/autoloader"
EGIT_REPO_URI="https://github.com/php-fedora/autoloader.git"

LICENSE="MIT"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.0.1-tests-DependenciesTest.patch
	"${FILESDIR}/${PN}"-1.0.1-tests-FunctionsTest.patch )

composer_enable_tests phpunit
