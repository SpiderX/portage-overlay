# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/FileIterator"
PHP_MIN_VER="8.3"

inherit composer

DESCRIPTION="FilterIterator implementation that filters files"
HOMEPAGE="https://github.com/sebastianbergmann/php-file-iterator"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t fedora2 src
}
