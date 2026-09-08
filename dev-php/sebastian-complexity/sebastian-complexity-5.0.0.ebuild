# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/Complexity"

PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="Library for calculating the complexity of PHP code units"
HOMEPAGE="https://github.com/sebastianbergmann/complexity"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/nikic-php-parser"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
