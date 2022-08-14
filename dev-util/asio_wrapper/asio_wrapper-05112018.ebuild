# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="9cb8c94"

DESCRIPTION="ASIO standalone CMake installer"
HOMEPAGE="https://github.com/compwizk/asio_wrapper"
SRC_URI="https://api.github.com/repos/compwizk/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-cpp/asio"

S="${WORKDIR}/compwizk-${PN}-${COMMIT}"

src_prepare() {
	sed -i  -e "/EXPORT_DEST/s|lib/\${PROJECT_NAME}|$(get_libdir)/cmake|" \
		-e "/LIB_DEST/s|lib|$(get_libdir)|" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}
