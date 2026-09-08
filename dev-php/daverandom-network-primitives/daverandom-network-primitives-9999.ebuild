# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="DaveRandom/Network"
COMPOSER_PKG="NetworkPrimitives"

inherit composer git-r3

DESCRIPTION="Primitive types for network programming in PHP"
HOMEPAGE="https://github.com/DaveRandom/NetworkPrimitives"
EGIT_REPO_URI="https://github.com/DaveRandom/NetworkPrimitives.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-php/daverandom-enum"

src_install() {
	composer_src_install

	insinto /usr/share/php/NetworkInterop
	doins -r interfaces/.
	newins "${FILESDIR}"/autoload-interfaces.php autoload.php
}
