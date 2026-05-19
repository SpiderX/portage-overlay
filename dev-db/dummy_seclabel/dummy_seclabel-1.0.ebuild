# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit postgres

MY_PV="REL_18_4"

DESCRIPTION="Regression testing of the SECURITY LABEL"
HOMEPAGE="https://github.com/postgres/postgres"
SRC_URI="https://github.com/postgres/postgres/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/postgres-${MY_PV}/src/test/modules/${PN}"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${POSTGRES_DEP}"

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake USE_PGXS=1 DESTDIR="${D}" install
}
