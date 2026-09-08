# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/LinesOfCode"
PHP_MIN_VER="8.3"

inherit composer git-r3

DESCRIPTION="Library for counting the lines of code in PHP source code"
HOMEPAGE="https://github.com/sebastianbergmann/lines-of-code"
EGIT_REPO_URI="https://github.com/sebastianbergmann/lines-of-code.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-php/nikic-php-parser"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
