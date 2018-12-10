# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/pipelinedb/${PN}.git"

inherit git-r3 python-any-r1

DESCRIPTION="High-performance time-series aggregation for PostgreSQL"
HOMEPAGE="https://www.pipelinedb.com/ https://github.com/pipelinedb/pipelinedb"
SRC_URI=""

LICENSE="Apache-2.0"
KEYWORDS=""
SLOT="0"
IUSE="test"

# some tests fail
RESTRICT="test"

DEPEND="dev-db/postgresql:*
	net-libs/zeromq:0="
RDEPEND="${DEPEND}"
BDEPEND="test? ( $(python_gen_any_dep 'dev-python/psycopg:2[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]') )"

python_check_deps() {
	has_version "dev-python/psycopg:2[${PYTHON_USEDEP}]" \
		&& has_version "dev-python/pytest[${PYTHON_USEDEP}]"
}

src_prepare() {
	default

	# Link with correct filename, support for DESTDIR
	sed -i -e '/SHLIB_LINK/s/a/so/' \
		-e '/headers_dir /s/= \$/= \${DESTDIR}\$/' \
		Makefile || die "sed failed for Makefile"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_compile() {
	emake USE_PGXS=1
}
