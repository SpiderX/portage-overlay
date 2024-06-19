# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Log what files are accessed by any Linux process"
HOMEPAGE="https://github.com/spieglt/whatfiles"
SRC_URI="https://github.com/spieglt/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default

	sed -i  -e '/CFLAGS/s|=|+=|' \
		-e '/$(CC) $(CFLAGS)/s|$(CC) $(CFLAGS)|$(CC) $(CFLAGS) $(LDFLAGS)|' \
		Makefile || die "sed failed for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin bin/whatfiles
}
