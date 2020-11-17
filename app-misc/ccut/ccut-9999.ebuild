# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/ColumPaget/ColumsCut.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="A unix cut command with a couple of extra features"
HOMEPAGE="https://github.com/ColumPaget/ColumsCut"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

src_prepare() {
	default

	# Redefine compiler call
	sed -i "s/\tcc/\t\${cc}/" Makefile || die "sed failed for Makefile"
}

src_compile() {
	emake cc="$(tc-getCC)"
}

src_install() {
	einstalldocs
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
