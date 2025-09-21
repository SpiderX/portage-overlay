# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="C library for Client Side and Queryable Encryption in MongoDB"
HOMEPAGE="https://github.com/mongodb/libmongocrypt"
EGIT_REPO_URI="https://github.com/mongodb/${PN}.git"

LICENSE="Apache-2.0 BSD ISC"
SLOT="0"
IUSE="dfp static-libs test"
REQUIRED_USE="test? ( static-libs )"
RESTRICT="!test? ( test )"

DEPEND=">=dev-libs/libbson-1.30.3
	dev-libs/openssl:=
	dfp? ( dev-libs/intel-dfp )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-1.15.1-static-libs.patch )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	cmake_src_prepare

	# https://salsa.debian.org/debian/intelrdfpmath/-/blob/master/debian/rules
	# package search name in Debian style
	sed -i '/find_library/s|gcc000||' cmake/ImportDFP.cmake \
		|| die "sed failed for ImportDFP.cmake"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test ON OFF)"
		-DBUILD_VERSION="${PV}"
		-DENABLE_ONLINE_TESTS=OFF
		-DENABLE_STATIC="$(usex static-libs ON OFF)"
		-DMONGOCRYPT_DFP_DIR="$(usex dfp USE-SYSTEM '')"
		-DMONGOCRYPT_ENABLE_DECIMAL128="$(usex dfp ON OFF)"
		-DMONGOCRYPT_MONGOC_DIR=USE-SYSTEM
		-DUSE_SHARED_LIBBSON=ON
	)
	cmake_src_configure
}
