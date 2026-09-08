# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Http/Message"

inherit composer

DESCRIPTION="Implementation of PSR-17 (HTTP Message Factories)"
HOMEPAGE="https://github.com/php-fig/http-factory"
SRC_URI="https://github.com/php-fig/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-http-message"

src_prepare() {
	default

	edo mkdir -p src/Factory
	edo phpab -q -o src/Factory/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
