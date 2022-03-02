# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SIP (RFC3261) implementation"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belle-sip"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="static-libs test zeroconf"
PROPERTIES="test_network"
RESTRICT="!test? ( test )"

RDEPEND="net-libs/bctoolbox[test?]
	sys-libs/zlib:=
	zeroconf? ( net-dns/avahi[mdnsresponder-compat] )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_MDNS="$(usex zeroconf)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TESTS="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	# no cmake_src_test since it supports in source build only
	"${S}"_build/tester/belle_sip_tester \
		--resource-dir "${S}"/tester/ \
		|| die "tests failed"
}
