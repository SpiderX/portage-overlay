# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/BelledonneCommunications/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Language recognition library by Belledonne Communications"
HOMEPAGE="https://github.com/BelledonneCommunications/belr"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="static-libs test tools"
RESTRICT="test"

RDEPEND="net-libs/bctoolbox[test?]"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TESTS="$(usex test)"
		-DENABLE_TOOLS="$(usex tools)"
	)

	cmake_src_configure
}
