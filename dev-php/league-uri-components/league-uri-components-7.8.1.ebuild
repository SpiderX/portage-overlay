# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="Components"
COMPOSER_INSTALL_PATH="League/Uri"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="League URI Components"
HOMEPAGE="https://github.com/thephpleague/uri-components"
SRC_URI="https://github.com/thephpleague/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-php/league-uri"
