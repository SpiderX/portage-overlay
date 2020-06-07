# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Mass parallel ssh"
HOMEPAGE="https://github.com/ndenev/mpssh"
SRC_URI="https://github.com/ndenev/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/openssh"

src_prepare() {
	default

	# Respect CFLAGS and LDFLAGS
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
