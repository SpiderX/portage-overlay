# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/DaveRandom/NetworkPrimitives.git"

inherit git-r3

DESCRIPTION="Primitive types for network programming in PHP"
HOMEPAGE="https://github.com/DaveRandom/NetworkPrimitives"

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
	doins -r "${FILESDIR}"/autoload-interfaces.php interfaces/.
}
