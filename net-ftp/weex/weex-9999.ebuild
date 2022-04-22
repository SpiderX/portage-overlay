# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECVS_SERVER="weex.cvs.sourceforge.net:/cvsroot/weex"
ECVS_MODULE="weex"
ECVS_TOPDIR="${DISTDIR}/cvs-src/${ECVS_MODULE}"

inherit autotools cvs

DESCRIPTION="A non-interactive FTP client for updating web pages"
HOMEPAGE="https://sourceforge.net/projects/weex/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND="sys-libs/ncurses:0=[tinfo]
	sys-libs/readline:0=
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${ECVS_MODULE}

PATCHES=( "${FILESDIR}"/"${P}"-configure.in.patch
	"${FILESDIR}"/"${PN}"-2.8.2-Makefile.am.patch
	"${FILESDIR}"/"${P}"-src-Makefile.am.patch )

src_prepare() {
	default
	mv configure.{in,ac} || die "rename failed"
	eautoreconf
	cp /usr/share/gettext/po/Makevars.template \
	"${S}"/po/Makevars || die "cp Makevars failed"
	cp -f "${FILESDIR}"/strlib.{c,h} "${S}"/src \
	|| die "cp strlib failed"
}

src_configure() {
	econf "$(use_enable nls)"
}
