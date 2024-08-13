# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/amphp/hpack.git"

inherit git-r3

DESCRIPTION="HTTP/2 header compression implementation in PHP"
HOMEPAGE="https://github.com/amphp/hpack"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # needs separate package with test data

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Http
	doins -r "${FILESDIR}"/autoload.php src/.
}
