# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Mass parallel ssh"
HOMEPAGE="https://github.com/ndenev/mpssh"
EGIT_REPO_URI="https://github.com/ndenev/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="net-misc/openssh"

src_prepare() {
	default

	# respect CFLAGS and LDFLAGS
	sed  -i -e '/CFLAGS/s/=/ +=/' \
		-e '/LDFLAGS/s/=/+=/' \
		Makefile || die "sed faild for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin mpssh
	doman mpssh.1
}
