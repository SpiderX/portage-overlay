# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A single-file header-only version of a C++17-like string_view"
HOMEPAGE="https://github.com/martinmoene/string-view-lite"
SRC_URI="https://github.com/martinmoene/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DSTRING_VIEW_LITE_OPT_BUILD_TESTS="$(usex test)"
	)

	cmake_src_configure
}
