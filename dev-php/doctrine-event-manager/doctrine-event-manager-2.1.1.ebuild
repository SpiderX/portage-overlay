# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine/Common"

inherit composer

DESCRIPTION="Doctrine Event Manager"
HOMEPAGE="https://github.com/doctrine/event-manager"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir src/EventManager
	edo phpab -q -o src/EventManager/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
