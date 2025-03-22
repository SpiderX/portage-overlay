# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2016

EAPI=8

RUST_REQ_USE="rustfmt"
LLVM_COMPAT=( {15..19} )
POSTGRES_COMPAT=( {12..17} )
POSTGRES_USEDEP="server"
EGIT_REPO_URI="https://gitlab.com/dalibo/${PN}.git"

inherit cargo git-r3 llvm-r2 postgres

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"

LICENSE="Apache-2.0 BSD ISC MIT POSTGRESQL Unicode-DFS-2016"
SLOT="0"
REQUIRED_USE="${POSTGRES_REQ_USE} ${LLVM_REQUIRED_USE}"
RESTRICT="test" # installs extension outside of sandbox

RDEPEND="${POSTGRES_DEP}"
BDEPEND="dev-util/cargo-pgrx
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
	cargo_src_unpack
}

src_prepare() {
	default

	# fix warnings (https://github.com/pgcentralfoundation/pgrx/issues/1966)
	sed -i  -e '/pg12/s|#||' \
		-e '$a\\n[lints.rust]' \
		-e '$aunexpected_cfgs = { level = "warn", check-cfg = ["cfg(pgrx_embed)"] }' \
		Cargo.toml || die "sed failed"

	export PGRX_HOME="${WORKDIR}/${P}"/.pgrx
	cargo pgrx init --pg"${PG_SLOT}" "${PG_CONFIG}" || die "cargo pgrx failed"
}

src_compile() {
	emake extension PGVER=pg"${PG_SLOT}"
}

src_test() {
	emake test PGVER=pg"${PG_SLOT}"
}

src_install() {
	einstalldocs

	local PG_LIBDIR PG_SHAREDIR
	PG_LIBDIR="$($PG_CONFIG --libdir)"
	PG_SHAREDIR="$($PG_CONFIG --sharedir)"

	dodir "${PG_SHAREDIR}"/extension "${PG_LIBDIR}"
	emake install PGVER=pg"${PG_SLOT}" \
		PG_SHAREDIR="${ED}/${PG_SHAREDIR}" \
		TARGET_SHAREDIR="target/release/anon-pg${PG_SLOT}/${PG_SHAREDIR}" \
		PG_LIBDIR="${ED}/${PG_LIBDIR}" \
		TARGET_LIBDIR="target/release/anon-pg${PG_SLOT}/${PG_LIBDIR}"
}
