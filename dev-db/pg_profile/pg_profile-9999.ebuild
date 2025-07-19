# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Postgres historic performance reports"
HOMEPAGE="https://github.com/zubkov-andrei/pg_profile"
EGIT_REPO_URI="https://github.com/zubkov-andrei/${PN}.git"

LICENSE="POSTGRESQL"
SLOT="0"

RDEPEND="dev-db/postgresql:*"

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake USE_PGXS=1 DESTDIR="${D}" install
}
