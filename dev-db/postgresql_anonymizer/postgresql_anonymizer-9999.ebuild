# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.com/dalibo/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
SRC_URI=""

LICENSE="POSTGRESQL"
KEYWORDS=""
SLOT="0"

DEPEND="dev-db/postgresql:="

DOCS=( {CHANGELOG,NEWS,README}.md )

src_compile() {
	default

	pushd pg_dump_anon
	ego build -o ../bin/pg_dump_anon main.go
	popd
}

src_install() {
	default

	local PGSLOT="$(postgresql-config show)"
	exeinto /usr/"$(get_libdir)"/postgresql-"${PGSLOT}"/bin/
	doexe bin/pg_dump_anon
}
