# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

WEBAPP_MANUAL_SLOT="yes"
MY_PN="${PN/-/}"

DESCRIPTION="Online diagramming web application"
HOMEPAGE="https://github.com/jgraph/drawio"
SRC_URI="https://github.com/jgraph/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE="vhosts"

DEPEND="${WEBAPP_DEPEND}"
RDEPEND="${DEPEND}"

src_install() {
	webapp_src_preinst
	cp -R src/main/webapp/* "${ED}"/"${MY_HTDOCSDIR}" || die "cp failed"
	webapp_src_install

	einstalldocs
}
