# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Hexdump utility from vim"
HOMEPAGE="https://github.com/vim/vim"
SRC_URI="https://raw.githubusercontent.com/vim/vim/v${PV}/src/xxd/xxd.c
	https://raw.githubusercontent.com/vim/vim/v${PV}/runtime/doc/xxd.1
	https://raw.githubusercontent.com/vim/vim/v${PV}/src/xxd/Makefile"
S="${WORKDIR}"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

RDEPEND="!app-editors/vim-core"

src_unpack() {
	edo cp "${DISTDIR}"/{Makefile,xxd.{c,1}} "${S}"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin xxd
	doman xxd.1
}
