# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/Environment"
PHP_MIN_VER="8.3"

inherit composer git-r3

DESCRIPTION="PHP code that has runtime-specific execution paths"
HOMEPAGE="https://github.com/sebastianbergmann/environment"
EGIT_REPO_URI="https://github.com/sebastianbergmann/environment.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
# tests depend on exact php -n / ini default handling
EPHPUNIT_EXCLUDE_FILTER='testGetCurrentSettings(Skips|Reports|Leaves)'
composer_enable_tests phpunit

src_prepare() {
	default

	edo mkdir vendor
	edo phpab -q -o src/autoload.php -t fedora2 src
	edo phpab -q -o vendor/autoload.php -t "${FILESDIR}"/autoload-test.php.tpl tests
}
