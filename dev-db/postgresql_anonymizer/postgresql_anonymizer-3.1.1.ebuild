# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"
RUST_REQ_USE="rustfmt"
LLVM_COMPAT=( {16..22} )
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit cargo edo llvm-r2 postgres-multi

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
SRC_URI="https://gitlab.com/dalibo/${PN}/-/archive/${PV}/${P}.tar.bz2
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-crates.tar.xz"

LICENSE="Apache-2.0 BSD ISC MIT POSTGRESQL Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${POSTGRES_REQ_USE} ${LLVM_REQUIRED_USE}"

RDEPEND="${POSTGRES_DEP}"
BDEPEND=">=dev-util/cargo-pgrx-0.18.0
	virtual/pkgconfig
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')"

DOCS=( {CHANGELOG,NEWS,README}.md )

QA_FLAGS_IGNORED="usr/lib.*/postgresql-.*/lib.*/anon.so"

pkg_setup() {
	llvm-r2_pkg_setup
	postgres-multi_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	# apply patches before postgres-multi_src_prepare copies src for each PostgreSQL version
	eapply "${FILESDIR}/${PN}"-3.1.1-Makefile.patch
	eapply "${FILESDIR}/${PN}"-3.1.1-tests.patch
	postgres-multi_src_prepare
}

postgresql_anonymizer_compile() {
	export PGRX_HOME="${T}/pgrx-pg${PG_SLOT}"
	edo cargo pgrx init --pg"${PG_SLOT}" "${PG_CONFIG}"
	emake extension PGVER="pg${PG_SLOT}" PG_CONFIG="${PG_CONFIG}"
}

src_compile() {
	postgres-multi_foreach postgresql_anonymizer_compile
}

# the pgrx test suite installs the extension into PostgreSQL's system
# directories and cannot run inside the Portage sandbox.  Run the upstream
# SQL regression suite against a temporary PostgreSQL instance instead.
# This currently requires extension_control_path, which is available since 18.
postgresql_anonymizer_test() {
	[[ ${PG_SLOT} == 18 ]] || return 0

	local db port extensiondir libdir pkgdir
	db="${T}/pgsql-${PG_SLOT}"
	port="54${PG_SLOT}"
	pkgdir="${PWD}/target/release/anon-pg${PG_SLOT}"
	extensiondir="${pkgdir}$("${PG_CONFIG}" --sharedir)/extension"
	libdir="${pkgdir}$("${PG_CONFIG}" --pkglibdir)"

	sed -i -e "s/@PGPORT@/${port}/g" tests/sql/test_replica_masking.sql \
		tests/expected/test_replica_masking.out || die

	edo initdb -U portage -A trust -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h 127.0.0.1 -k '${T}' -p ${port} \
		-c wal_level=logical \
		-c extension_control_path='${extensiondir}:\$system' \
		-c dynamic_library_path='${libdir}:\$libdir'"
	emake installcheck INSTALLCHECK_DEPS= PGVER="pg${PG_SLOT}" PGHOST="${T}" PGPORT="${port}"
	edo pg_ctl -w -D "${db}" stop
}

src_test() {
	postgres-multi_foreach postgresql_anonymizer_test
}

postgresql_anonymizer_install() {
	local PG_PKGLIBDIR PG_SHAREDIR

	PG_PKGLIBDIR="$("${PG_CONFIG}" --pkglibdir)"
	PG_SHAREDIR="$("${PG_CONFIG}" --sharedir)"

	dodir "${PG_SHAREDIR}"/extension "${PG_PKGLIBDIR}"

	emake install PG_CONFIG="${PG_CONFIG}" \
		PG_PKGLIBDIR="${ED}/${PG_PKGLIBDIR}" \
		PG_SHAREDIR="${ED}/${PG_SHAREDIR}" \
		PGVER="pg${PG_SLOT}" \
		TARGET_PKGLIBDIR="target/release/anon-pg${PG_SLOT}/${PG_PKGLIBDIR}" \
		TARGET_SHAREDIR="target/release/anon-pg${PG_SLOT}/${PG_SHAREDIR}"
}

src_install() {
	einstalldocs
	postgres-multi_foreach postgresql_anonymizer_install
}
