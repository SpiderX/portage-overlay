# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Windows Registry Reader"
HOMEPAGE="https://github.com/amphp/windows-registry"
EGIT_REPO_URI="https://github.com/amphp/windows-registry.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/amphp-byte-stream
	dev-php/amphp-process
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/WindowsRegistry
	doins -r "${FILESDIR}"/autoload.php src/.
}
