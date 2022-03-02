# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Language recognition library by Belledonne Communications"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belr"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="static-libs test tools"
RESTRICT="test" # fails: need environment

RDEPEND="net-libs/bctoolbox[test?]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/libudev
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TESTS="$(usex test)"
		-DENABLE_TOOLS="$(usex tools)"
	)

	cmake_src_configure
}

src_test() {
	"${S}"_build/tester/belr_tester || die "tests failed"

	cmake_src_test
}
