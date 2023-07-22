# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Read variables from INI-style configuration files"
HOMEPAGE="https://devel.ringlet.net/textproc/confget/"
SRC_URI="https://devel.ringlet.net/files/textproc/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libpcre2:0=
	sys-libs/readline:0="
RDEPEND="${DEPEND}"

src_compile() {
	export NO_DOC_BUILD=1
	emake LOCALBASE="${EPREFIX}/usr" CC="$(tc-getCC)"
}

src_install() {
	doman confget.1
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" STRIP= \
		MANDIR="${EPREFIX}"/usr/share/man install
}
