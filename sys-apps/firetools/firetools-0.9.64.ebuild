# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Graphical user interface of Firajail security sandbox"
HOMEPAGE="https://firejail.wordpress.com https://github.com/netblue30/firetools"
SRC_URI="https://github.com/netblue30/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	|| ( sys-apps/firejail sys-apps/firejail-lts )"
RDEPEND="${DEPEND}
	x11-terms/xterm"

src_prepare() {
	default

	# Don't install license and compressed mans
	sed -i  -e '/install -c -m 0644 COPYING \$(DESTDIR)\/\$(DOCDIR)\/\./d' \
		-e '/install -c -m 0644/s/.gz//' \
		-e '/gzip/d' \
		Makefile.in || die "sed failed for Makefile.in"
}

src_compile() {
	emake CXX="$(tc-getCXX)"
}
