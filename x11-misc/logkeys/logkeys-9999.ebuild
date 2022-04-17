# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/kernc/${PN}.git"

inherit autotools git-r3 systemd

DESCRIPTION="A Linux keylogger"
HOMEPAGE="https://github.com/kernc/logkeys"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="suid"

DEPEND=""
RDEPEND=""

src_prepare() {
	default

	sed -i 's/CXXFLAGS = -Wall -O3/AM_CXXFLAGS = $(CXXFLAGS) -Wall/' \
		src/Makefile.am || die "sed failed for Makefile.am"

	eautoreconf
}

src_install() {
	default

	insinto /usr/share/"${PN}"
	doins keymaps/*.map

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service

	if ! use suid; then
		rm -f "${ED}"/etc/logkeys-{kill,start}.sh || die "remove logkeys failed"
		rm -f "${ED}"/usr/bin/llk{,k} || die "remove llk(k) failed"
	fi
}
