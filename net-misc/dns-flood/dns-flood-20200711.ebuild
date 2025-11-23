# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="5330bac30f62165093c9c896906cef2156f95f2f"

DESCRIPTION="Use raw sockets to generate DNS flood attack"
HOMEPAGE="https://github.com/hawell/dns-flood"
SRC_URI="https://github.com/hawell/dns-flood/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
