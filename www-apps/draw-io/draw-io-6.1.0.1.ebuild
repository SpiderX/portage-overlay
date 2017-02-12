# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PN="${PN/-/.}"

inherit webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="Online diagramming web application"
HOMEPAGE="https://github.com/jgraph/${MY_PN}"
SRC_URI="https://github.com/jgraph/${MY_PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE="vhosts"
DOCS=( README.md )
DEPEND="${WEBAPP_DEPEND}"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	webapp_src_preinst
	cp -R war/* "${ED%/}"/"${MY_HTDOCSDIR}" || die "cp failed"
	webapp_src_install

	einstalldocs
}
