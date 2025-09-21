# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Primitive types for network programming in PHP"
HOMEPAGE="https://github.com/DaveRandom/NetworkPrimitives"
EGIT_REPO_URI="https://github.com/DaveRandom/NetworkPrimitives.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/daverandom-enum
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/DaveRandom/Network
	doins -r "${FILESDIR}"/autoload.php src/.
	insinto /usr/share/php/NetworkInterop
	doins -r interfaces/.
	newins "${FILESDIR}"/autoload-interfaces.php autoload.php
}
