# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Use raw sockets to generate DNS flood attack"
HOMEPAGE="https://github.com/hawell/dns-flood"
EGIT_REPO_URI="https://github.com/hawell/dns-flood.git"

LICENSE="Apache-2.0"
SLOT="0"

src_prepare() {
	default

	sed -i 's/gcc -o $(TARGET) -O2 -g/$(CC) -o $(TARGET) ${CFLAGS} ${LDFLAGS} -g/' \
		makefile || die "sed failed for makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dosbin dnsflood
}
