# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="VCard standard format manipulation library"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belcard"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="static-libs test tools"
RESTRICT="!test? ( test )"

RDEPEND="dev-cpp/belr
	net-libs/bctoolbox[test?]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	"${S}"_build/tester/belcard_tester \
		--resource-dir "${S}"/tester/ \
		|| die "tests failed"

	cmake_src_test
}
