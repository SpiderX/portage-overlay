# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/RhodiumToad/${PN}.git"

inherit git-r3

DESCRIPTION="IP address and IP range index types for PostgreSQL"
HOMEPAGE="https://github.com/RhodiumToad/ip4r"

LICENSE="POSTGRESQL"
SLOT="0"

DEPEND="dev-db/postgresql:*"

src_prepare() {
	default

	# fix QA
	sed -i '/DOCS/d' Makefile || die "sed failed"
}

src_compile() {
	emake USE_PGXS=1
}

src_test() {
	local db="${T}/pgsql"
	initdb -U portage -A trust -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	PGHOST="${T}" emake installcheck
	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

src_install() {
	emake USE_PGXS=1 DESTDIR="${D}" install
}
