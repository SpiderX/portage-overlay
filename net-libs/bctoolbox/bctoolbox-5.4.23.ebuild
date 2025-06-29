# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Utilities library used by Belledonne Communications softwares"
HOMEPAGE="https://gitlab.linphone.org/BC/public/bctoolbox"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mbedtls +openssl test"
PROPERTIES="test_network"
# test doesn't build with mbedtls
REQUIRED_USE="^^ ( mbedtls openssl ) test? ( openssl )"
RESTRICT="!test? ( test )"

RDEPEND="mbedtls? ( net-libs/mbedtls:3= )
	openssl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-util/bcunit )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_MBEDTLS="$(usex mbedtls)"
		-DENABLE_OPENSSL="$(usex openssl)"
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
