# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/BelledonneCommunications/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Utilities library used by Belledonne Communications softwares"
HOMEPAGE="https://github.com/BelledonneCommunications/bctoolbox"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="ssl static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="ssl? ( net-libs/mbedtls )"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-util/bcunit )"

src_prepare() {
	sed -i 's/CU_automated_enable_partial_junit/CU_automated_enable_junit_xml/' \
		src/tester.c || die "sed failed for src/tester.c"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_POLARSSL=OFF
		-DENABLE_MBEDTLS="$(usex ssl)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TESTS_COMPONENT="$(usex test)"
		-DENABLE_TESTS="$(usex test)"
	)

	cmake_src_configure
}
