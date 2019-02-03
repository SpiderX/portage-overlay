# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/netblue30/${PN}.git"

inherit git-r3 qmake-utils

DESCRIPTION="Graphical user interface of Firajail security sandbox"
HOMEPAGE="https://firejail.wordpress.com https://github.com/netblue30/firetools"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	|| ( sys-apps/firejail sys-apps/firejail-lts )"
RDEPEND="${DEPEND}
	x11-terms/xterm"

src_prepare() {
	default

	# Don't install license
	sed -i '/install -c -m 0644 COPYING \$(DESTDIR)\/\$(DOCDIR)\/\./d' \
		Makefile.in || die "sed failed for Makefile.in"
}

src_configure() {
	econf --with-qmake="$(qt5_get_bindir)"/qmake
}
