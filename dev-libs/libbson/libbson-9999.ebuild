# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13,14} )

inherit cmake git-r3 python-any-r1

DESCRIPTION="Library routines related to building,parsing and iterating BSON documents"
HOMEPAGE="https://github.com/mongodb/mongo-c-driver/tree/master/src/libbson"
EGIT_REPO_URI="https://github.com/mongodb/mongo-c-driver.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="static-libs test"
RESTRICT="test" # tests need exact version of libbson

BDEPEND="virtual/pkgconfig
	test? ( $(python_gen_any_dep 'dev-python/jinja2[${PYTHON_USEDEP}]
			dev-python/legacy-cgi[${PYTHON_USEDEP}]') )"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare

	# remove doc files
	sed -i '/^\s*install\s*(FILES COPYING NEWS/,/^\s*)/ {d}' CMakeLists.txt \
		|| die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_EXAMPLES=OFF
		-DENABLE_MONGOC=OFF
		-DENABLE_STATIC="$(usex static-libs ON OFF)"
		-DENABLE_TESTS=OFF
		-DENABLE_UNINSTALL=OFF
	)
	cmake_src_configure
}
