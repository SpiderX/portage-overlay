# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit git-r3 postgres

DESCRIPTION="Regression testing of the SECURITY LABEL"
HOMEPAGE="https://github.com/postgres/postgres"
EGIT_REPO_URI="https://github.com/postgres/postgres.git"
S="${WORKDIR}/${PN}-${PV}/src/test/modules/${PN}"

LICENSE="POSTGRESQL"
SLOT="0"

RDEPEND="${POSTGRES_DEP}"

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake USE_PGXS=1 DESTDIR="${D}" install
}
