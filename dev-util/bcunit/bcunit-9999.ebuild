# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="BC Unit Test Framework"
HOMEPAGE="https://gitlab.linphone.org/BC/public/bcunit"
EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug doc examples test"
RESTRICT="test" # fails: BCUnit_intl.h: No such file or directory

BDEPEND="virtual/pkgconfig"

src_configure() {
	# interface to ncurses broken
	local mycmakeargs=(
		-DENABLE_BCUNIT_CURSES="OFF"
		-DENABLE_BCUNIT_DOC="$(usex doc)"
		-DENABLE_BCUNIT_EXAMPLES="$(usex examples)"
		-DENABLE_BCUNIT_MEMTRACE="$(usex debug)"
		-DENABLE_BCUNIT_TEST="$(usex test)"
	)

	cmake_src_configure
}
