# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Check multiple mailboxes/maildirs for mail from the command line"
HOMEPAGE="https://mailcheck.sourceforge.net"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${P//-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/${P}"-username.patch
	"${FILESDIR}/${P}"-advanced-counting.patch
	"${FILESDIR}/${P}"-makefile.patch )

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin mailcheck
	insinto /etc
	doins mailcheckrc
	doman mailcheck.1
}
