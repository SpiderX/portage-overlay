# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${P}-x86_64"

inherit autotools toolchain-funcs

DESCRIPTION="Demos Commander, a free Norton Commander clone"
HOMEPAGE="https://sourceforge.net/projects/deco/"
SRC_URI="https://topola.unity.net/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0=[tinfo]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	# Fix link against libtinfo when it separate from libncurses
	sed -i '/tgetent/aAC_SEARCH_LIBS([stdscr], [tinfo], ,[AC_MSG_ERROR([Cannot find a library providing stdscr])])' \
		configure.in || die "sed failed for configure.in"

	# Bug #426262, create directories
	mv configure.{in,ac} || die "rename failed"
	sed -i -e '/configure./s/in/ac/' \
		-e 's/mkdir/mkdir -p/' \
		-e '/$(INSTALL_PROGRAM)/i\\t\tmkdir -p $(bindir)' \
		-e '/f.man/s/$(INSTALL_DATA)/$(INSTALL_DATA) -D/' \
		Makefile.in || die "sed failed for Makefile.in"

	eautoreconf
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)"
}

src_install() {
	emake bindir="${ED}/usr/bin/" libdir="${ED}/usr/$(get_libdir)" \
		mandir="${ED}/usr/share/man" install
}
