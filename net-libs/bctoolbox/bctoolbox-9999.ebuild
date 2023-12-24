# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Utilities library used by Belledonne Communications softwares"
HOMEPAGE="https://gitlab.linphone.org/BC/public/bctoolbox"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug ssl test"
PROPERTIES="test_network"
RESTRICT="!test? ( test )"

RDEPEND="ssl? ( net-libs/mbedtls:0= )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-util/bcunit )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_MBEDTLS="$(usex ssl)"
		-DENABLE_STRICT=NO
		-DENABLE_TESTS_COMPONENT="$(usex test)"
		-DENABLE_UNIT_TESTS="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	"${S}"_build/tester/bctoolbox-tester || die "tests failed"

	cmake_src_test
}
