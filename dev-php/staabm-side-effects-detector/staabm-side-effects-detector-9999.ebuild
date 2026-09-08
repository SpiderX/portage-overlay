# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="staabm/SideEffectsDetector"
COMPOSER_INSTALL_SRC="lib"
PHP_REQ_USE="tokenizer"

inherit composer git-r3

DESCRIPTION="Analyzes php-code for side-effects"
HOMEPAGE="https://github.com/staabm/side-effects-detector"
EGIT_REPO_URI="https://github.com/staabm/side-effects-detector.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-php/theseer-Autoload"

PATCHES=( "${FILESDIR}/${PN}"-1.0.5-tests.patch )

EPHPUNIT_BOOTSTRAP='tests/autoload.php'
composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o lib/autoload.php -t "${FILESDIR}"/autoload.php.tpl lib
	edo phpab -q -o tests/autoload.php -t "${FILESDIR}"/autoload-test.php.tpl tests
}
