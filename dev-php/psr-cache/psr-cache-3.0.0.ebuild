# Copyright 1999-2026 Gentoo Authors
# Distributed under the t6rms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Cache"

inherit composer

DESCRIPTION="Common Cache Interface (PHP FIG PSR-6)"
HOMEPAGE="https://github.com/php-fig/cache"
SRC_URI="https://github.com/php-fig/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests
