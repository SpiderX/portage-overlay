# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Clock"

inherit composer

DESCRIPTION="Clock Interface (PHP FIG PSR-20)"
HOMEPAGE="https://github.com/php-fig/clock"
SRC_URI="https://github.com/php-fig/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests
