# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.82.0"
RUST_REQ_USE="rustfmt"
LLVM_COMPAT=( {15..20} )
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit cargo edo git-r3 llvm-r2 postgres

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
EGIT_REPO_URI="https://gitlab.com/dalibo/${PN}.git"

LICENSE="Apache-2.0 BSD ISC MIT POSTGRESQL Unicode-DFS-2016"
SLOT="0"
REQUIRED_USE="${POSTGRES_REQ_USE} ${LLVM_REQUIRED_USE}"
RESTRICT="test" # installs extension outside of sandbox

RDEPEND="${POSTGRES_DEP}"
BDEPEND=">=dev-util/cargo-pgrx-0.16.0
	virtual/pkgconfig
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')"

DOCS=( {CHANGELOG,NEWS,README}.md )

QA_FLAGS_IGNORED="usr/lib.*/postgresql-.*/lib.*/anon.so"

pkg_setup() {
	llvm-r2_pkg_setup
	postgres_pkg_setup
	rust_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	default

	export PGRX_HOME="${WORKDIR}/${P}"/.pgrx
	edo cargo pgrx init --pg"${PG_SLOT}" "${PG_CONFIG}"
}

src_compile() {
	emake extension PGVER=pg"${PG_SLOT}"
}

src_test() {
	emake test PGVER=pg"${PG_SLOT}"
}

src_install() {
	einstalldocs

	local PG_PKGLIBDIR PG_SHAREDIR
	PG_PKGLIBDIR="$($PG_CONFIG --libdir)"
	PG_SHAREDIR="$($PG_CONFIG --sharedir)"

	dodir "${PG_SHAREDIR}"/extension "${PG_PKGLIBDIR}"
	emake install PGVER=pg"${PG_SLOT}" \
		PG_SHAREDIR="${ED}/${PG_SHAREDIR}" \
		TARGET_SHAREDIR="target/release/anon-pg${PG_SLOT}/${PG_SHAREDIR}" \
		PG_PKGLIBDIR="${ED}/${PG_PKGLIBDIR}" \
		TARGET_PKGLIBDIR="target/release/anon-pg${PG_SLOT}/${PG_PKGLIBDIR}"
}
