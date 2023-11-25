# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/lib/pq v1.10.6"
	"github.com/lib/pq v1.10.6/go.mod"
	"golang.org/x/crypto v0.0.0-20220722155217-630584e8d5aa"
	"golang.org/x/crypto v0.0.0-20220722155217-630584e8d5aa/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
SRC_URI="https://gitlab.com/dalibo/${PN}/-/archive/${PV}/${P}.tar.bz2
	${EGO_SUM_SRC_URI}"

LICENSE="POSTGRESQL"
KEYWORDS="~amd64 ~x86"
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
