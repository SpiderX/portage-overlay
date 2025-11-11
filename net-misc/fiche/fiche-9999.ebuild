# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Command line pastebin server"
HOMEPAGE="https://github.com/solusipse/fiche"
EGIT_REPO_URI="https://github.com/solusipse/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="acct-group/fiche
	acct-user/fiche"

src_prepare() {
	default

	# remove CFLAGS defined by upstream
	sed -i 's/ -O2//' Makefile || die "sed for Makefile.in failed"
}

src_install() {
	dobin fiche

	newinitd "${FILESDIR}"/fiche.initd fiche
	newconfd "${FILESDIR}"/fiche.confd fiche
}
