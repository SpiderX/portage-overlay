# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Command line pastebin server"
HOMEPAGE="https://github.com/solusipse/fiche"
SRC_URI="https://github.com/solusipse/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="acct-user/fiche"

src_prepare() {
	default

	# Remove CFLAGS defined by upstream
	sed -i 's/ -O2//' Makefile || die "sed for Makefile.in failed"
}

src_install() {
	dobin fiche

	newinitd "${FILESDIR}"/fiche.initd fiche
	newconfd "${FILESDIR}"/fiche.confd fiche
}
