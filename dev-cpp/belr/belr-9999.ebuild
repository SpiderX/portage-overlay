# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Language recognition library by Belledonne Communications"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belr"
EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="test tools"
RESTRICT="!test? ( test )"

RDEPEND="net-libs/bctoolbox[test?]"
DEPEND="${RDEPEND}"
BDEPEND="virtual/libudev
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STRICT=NO
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS="$(usex test)"
	)
	cmake_src_configure
}

src_test() {
	"${S}"_build/tester/belr-tester --resource-dir "${S}"/tester/res \
		|| die "tests failed"
	cmake_src_test
}
