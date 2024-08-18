# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mongodb/mongo-c-driver.git"

inherit cmake git-r3

DESCRIPTION="Library routines related to building,parsing and iterating BSON documents"
HOMEPAGE="https://github.com/mongodb/mongo-c-driver/tree/master/src/libbson"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="static-libs"
RESTRICT="test"

BDEPEND="virtual/pkgconfig"

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
