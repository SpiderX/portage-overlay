# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/vovcat/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Measure reachability and latency of DNS nameservers"
HOMEPAGE="https://github.com/vovcat/nsping"
SRC_URI=""

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
