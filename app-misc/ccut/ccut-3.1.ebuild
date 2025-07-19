# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_PN="ColumsCut"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A unix cut command with a couple of extra features"
HOMEPAGE="https://github.com/ColumPaget/ColumsCut"
SRC_URI="https://github.com/ColumPaget/ColumsCut/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default

	# Redefine compiler call
	sed -i "s/\tcc/\t\${cc}/" Makefile || die "sed failed for Makefile"
	# Remove test that requires non-existed file
	sed -i '/tests\/multiline.txt/,+1d' check.sh || die "sed failed for check.sh"
}

src_compile() {
	emake cc="$(tc-getCC)"
}

src_install() {
	einstalldocs
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
