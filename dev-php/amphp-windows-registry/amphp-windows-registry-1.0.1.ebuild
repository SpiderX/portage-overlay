# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Windows Registry Reader"
HOMEPAGE="https://github.com/amphp/windows-registry"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
