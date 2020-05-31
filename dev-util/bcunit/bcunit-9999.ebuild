# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/BelledonneCommunications/${PN}.git"

inherit cmake-utils git-r3

DESCRIPTION="BC Unit Test Framework"
HOMEPAGE="https://github.com/BelledonneCommunications/bcunit"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ncurses static-libs test"
RESTRICT="test" # failed

RDEPEND="ncurses? ( sys-libs/ncurses:0= )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_CURSES="$(usex ncurses)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TEST="$(usex test)"
	)

	cmake-utils_src_configure
}
