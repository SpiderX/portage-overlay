# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/Version"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="Library that helps with managing the version number"
HOMEPAGE="https://github.com/sebastianbergmann/version"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
