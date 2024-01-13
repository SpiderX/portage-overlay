# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

inherit cmake git-r3

DESCRIPTION="C++ library implementing Open Whisper System Signal protocol"
HOMEPAGE="https://gitlab.linphone.org/BC/public/lime"

LICENSE="GPL-3"
SLOT="0"
IUSE="doc test"
RESTRICT="test" # fail: segfault

RDEPEND="dev-db/soci[sqlite]
	net-libs/bctoolbox[test?]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-text/doxygen )
	test? ( dev-libs/belle-sip )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STRICT="$(usex doc)"
		-DENABLE_STRICT=NO
		-DENABLE_UNIT_TESTS="$(usex test)"
	)

	cmake_src_configure
}
