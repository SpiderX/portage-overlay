# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/compwizk/${PN}.git"

inherit cmake git-r3

DESCRIPTION="ASIO standalone CMake installer"
HOMEPAGE="https://github.com/compwizk/asio_wrapper"
SRC_URI=""

LICENSE="MIT"
SLOT="2"
KEYWORDS=""

BDEPEND="dev-cpp/asio"

src_prepare() {
	sed -i  -e "/EXPORT_DEST/s|lib/\${PROJECT_NAME}|$(get_libdir)/cmake|" \
		-e "/LIB_DEST/s|lib|$(get_libdir)|" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}
