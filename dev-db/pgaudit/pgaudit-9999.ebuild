# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( 14 15 16 17 18 )

inherit git-r3 postgres

DESCRIPTION="PostgreSQL Audit Extension"
HOMEPAGE="https://github.com/pgaudit/pgaudit"
EGIT_REPO_URI="https://github.com/cybertec-postgresql/${PN}.git"

LICENSE="POSTGRESQL"
SLOT="0"
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
