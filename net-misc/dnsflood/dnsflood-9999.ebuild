# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hawell/dns-flood.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Use raw sockets to generate DNS flood attack"
HOMEPAGE="https://github.com/hawell/dns-flood"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dosbin dnsflood
}
