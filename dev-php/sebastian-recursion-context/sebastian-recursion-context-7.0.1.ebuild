# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/RecursionContext"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="Recursively process PHP variables"
HOMEPAGE="https://github.com/sebastianbergmann/recursion-context"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no phpunit.xml

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
