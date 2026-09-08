# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/PHPUnit"

inherit composer

DESCRIPTION="Helper package to ease testing with PHPUnit"
HOMEPAGE="https://github.com/amphp/phpunit-util"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/phpunit
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-3.0.0-phpunit12.patch
	"${FILESDIR}/${PN}"-3.0.0-tests.patch )

src_test() {
	ephpunit
}
