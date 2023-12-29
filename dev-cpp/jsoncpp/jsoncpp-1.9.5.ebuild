# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="CMake files for C++ JSON reader and writer"
HOMEPAGE="https://github.com/open-source-parsers/jsoncpp"
SRC_URI="https://github.com/open-source-parsers/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/jsoncpp:0="

src_configure() {
	local mycmakeargs=(
		-DJSONCPP_WITH_TESTS="$(usex test)"
		-DJSONCPP_WITH_POST_BUILD_UNITTEST="$(usex test)"
		-DBUILD_STATIC_LIBS="$(usex static-libs)"
		-DBUILD_OBJECT_LIBS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# remove everyting except cmake files
	rm -rf "${ED}"/usr/{include,share,lib64/pkgconfig,lib64/lib*} \
		|| die "rm failed"
	dosym ./libjsoncpp.so usr/"$(get_libdir)"/libjsoncpp.so."${PV}"
}
