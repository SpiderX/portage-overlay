# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
MY_PV="$(ver_rs 3 -)"
MY_P="${PN}-${MY_PV}"

inherit python-any-r1

DESCRIPTION="High-performance time-series aggregation for PostgreSQL"
HOMEPAGE="https://github.com/pipelinedb/pipelinedb"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
RESTRICT="test" # tests fail

DEPEND="<dev-db/postgresql-12:*
	net-libs/zeromq:0="
RDEPEND="${DEPEND}"
BDEPEND="test? ( $(python_gen_any_dep '
			dev-python/psycopg:2[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		') )"

S="${WORKDIR}/${MY_P}"

python_check_deps() {
	has_version "dev-python/psycopg:2[${PYTHON_USEDEP}]" \
		&& has_version "dev-python/pytest[${PYTHON_USEDEP}]"
}

src_prepare() {
	default

	# Link with correct filename, support for DESTDIR
	sed -i -e "/SHLIB_LINK/s|lib/libzmq.a|$(get_libdir)/libzmq.so|" \
		-e '/headers_dir /s/= \$/= \${DESTDIR}\$/' \
		Makefile || die "sed failed for Makefile"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_compile() {
	emake USE_PGXS=1
}
