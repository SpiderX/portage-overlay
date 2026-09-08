# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="DaveRandom/Network"
COMPOSER_PKG="NetworkPrimitives"

inherit composer

COMMIT="621fd76a2438294a46df81ada3355c95f690eedd"

DESCRIPTION="Primitive types for network programming in PHP"
HOMEPAGE="https://github.com/DaveRandom/NetworkPrimitives"
SRC_URI="https://github.com/DaveRandom/${COMPOSER_PKG}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${COMPOSER_PKG}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-php/daverandom-enum"

src_install() {
	composer_src_install

	insinto /usr/share/php/NetworkInterop
	doins -r interfaces/.
	newins "${FILESDIR}"/autoload-interfaces.php autoload.php
}
