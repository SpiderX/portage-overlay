# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="Measure reachability and latency of DNS nameservers"
HOMEPAGE="https://github.com/vovcat/nsping"
SRC_URI=""
EGIT_REPO_URI="https://github.com/vovcat/${PN}.git"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS=""
IUSE=""

src_prepare() {
	default

	# Remove debug, respect CFLAGS and LDFLAGS
	sed -i -e '/CFLAGS/s/=-g3 -Og /+=/' \
		-e '/LDFLAGS/s/=/+=/' \
		Makefile || die "sed faild for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	doman nsping.8
	dosbin nsping
}
