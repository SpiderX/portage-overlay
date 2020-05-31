# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Utilities library used by Belledonne Communications softwares"
HOMEPAGE="https://github.com/BelledonneCommunications/bctoolbox"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="ssl static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="ssl? ( net-libs/mbedtls )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-util/bcunit )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_POLARSSL=OFF
		-DENABLE_MBEDTLS="$(usex ssl ON OFF)"
		-DENABLE_STATIC="$(usex static-libs ON OFF)"
		-DENABLE_TESTS_COMPONENT="$(usex test ON OFF)"
		-DENABLE_TESTS="$(usex test ON OFF)"
	)

	cmake-utils_src_configure
}
