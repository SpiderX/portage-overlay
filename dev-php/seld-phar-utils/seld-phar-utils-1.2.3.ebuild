# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Seld/PharUtils"
PHP_REQ_USE="phar"

inherit composer

DESCRIPTION="PHAR file format utilities, for when PHP phars you up"
HOMEPAGE="https://github.com/Seldaek/phar-utils"
SRC_URI="https://github.com/Seldaek/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests
