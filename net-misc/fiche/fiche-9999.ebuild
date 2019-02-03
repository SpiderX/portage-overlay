# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/solusipse/${PN}.git"

inherit git-r3 user

DESCRIPTION="Command line pastebin server"
HOMEPAGE="https://github.com/solusipse/fiche"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

pkg_setup() {
	enewgroup fiche
	enewuser fiche -1 -1 /var/lib/fiche fiche
}

src_prepare() {
	default

	# Remove CFLAGS defined by upstream
	sed -i 's/ -O2//' Makefile || die "sed for Makefile.in failed"
}

src_install() {
	dobin fiche

	diropts -o fiche -g fiche -m 0755
	keepdir /var/lib/fiche

	newinitd "${FILESDIR}"/fiche.initd fiche
	newconfd "${FILESDIR}"/fiche.confd fiche
}
