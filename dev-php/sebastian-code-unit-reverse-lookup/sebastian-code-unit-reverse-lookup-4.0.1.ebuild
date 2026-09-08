# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/CodeUnitReverseLookup"

inherit composer

DESCRIPTION="Looks up which function or method a line of code belongs to"
HOMEPAGE="https://github.com/sebastianbergmann/code-unit-reverse-lookup"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t fedora2 src
}
