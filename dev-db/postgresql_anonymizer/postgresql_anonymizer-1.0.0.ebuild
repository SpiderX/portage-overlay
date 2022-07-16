# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
SRC_URI="https://gitlab.com/dalibo/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="POSTGRESQL"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="dev-db/postgresql:="

DOCS=( {CHANGELOG,NEWS,README}.md )

src_compile() {
	default

	ego build -o bin/pg_dump_anon ./pg_dump_anon/pg_dump_anon.go
}

src_install() {
	default

	local PGSLOT="$(postgresql-config show)"
	exeinto /usr/$(get_libdir)/postgresql-${PGSLOT}/bin/
	doexe bin/pg_dump_anon
}
