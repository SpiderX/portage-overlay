# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( 14 15 16 17 18 )

inherit postgres

DESCRIPTION="PostgreSQL Audit Extension"
HOMEPAGE="https://github.com/pgaudit/pgaudit"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # tests needs installed extension

RDEPEND="dev-db/postgresql:*"

pkg_pretend() {
	postgres_check_slot
}

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake USE_PGXS=1 DESTDIR="${D}" install
}
