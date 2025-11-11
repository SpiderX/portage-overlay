# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo git-r3

DESCRIPTION="A non-interactive FTP client for updating web pages"
HOMEPAGE="https://sourceforge.net/projects/weex/"
EGIT_REPO_URI="https://git.code.sf.net/p/${PN}/code-git"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug nls"

RDEPEND="dev-libs/openssl:0=
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}"/"${P}"-configure.in.patch
	"${FILESDIR}"/"${PN}"-2.8.2-Makefile.am.patch
	"${FILESDIR}"/"${P}"-src-Makefile.am.patch )

src_prepare() {
	default
	eautoreconf
	edo cp /usr/share/gettext/po/Makevars.template \
		po/Makevars
}

src_configure() {
	econf "$(use_enable debug)" "$(use_enable nls)"
}
