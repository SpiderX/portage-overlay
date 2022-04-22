# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A non-interactive FTP client for updating web pages"
HOMEPAGE="https://sourceforge.net/projects/weex/"
SRC_URI="https://deb.debian.org/debian/pool/main/w/${PN}/${P//-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls"

RDEPEND="dev-libs/openssl:0=
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}"/"${PN}"-2.8.3-configure.in.patch
	"${FILESDIR}"/"${PN}"-2.8.2-Makefile.am.patch
	"${FILESDIR}"/"${PN}"-2.8.2-po-fr.po.patch
	"${FILESDIR}"/"${PN}"-2.8.2-src-Makefile.am.patch )

src_prepare() {
	default
	mv configure.{in,ac} || die "rename failed"
	eautoreconf
	cp /usr/share/gettext/po/Makevars.template \
	"${S}"/po/Makevars || die "cp failed"
}

src_configure() {
	econf "$(use_enable debug)" "$(use_enable nls)"
}
