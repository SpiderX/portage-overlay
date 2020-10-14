# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/martinmoene/${PN}.git"

inherit cmake git-r3

DESCRIPTION="A single-file header-only version of a C++17-like string_view"
HOMEPAGE="https://github.com/martinmoene/string-view-lite"
SRC_URI=""

LICENSE="BSD-1"
KEYWORDS=""
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DSTRING_VIEW_LITE_OPT_BUILD_TESTS="$(usex test)"
	)

	cmake_src_configure
}
