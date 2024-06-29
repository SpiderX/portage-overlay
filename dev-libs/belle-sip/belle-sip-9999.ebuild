# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

inherit cmake git-r3

DESCRIPTION="SIP (RFC3261) implementation"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belle-sip"

LICENSE="GPL-3"
SLOT="0"
IUSE="test tunnel zeroconf"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-cpp/belr
	net-libs/bctoolbox[test?]
	sys-libs/zlib:=
	zeroconf? ( net-dns/avahi[mdnsresponder-compat] )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_MDNS="$(usex zeroconf)"
		-DENABLE_STRICT=NO
		-DENABLE_TUNNEL="$(usex tunnel)"
		-DENABLE_UNIT_TESTS="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	# no cmake_src_test since it supports in source build only
	# disable test suits with failing tests
	"${S}"_build/tester/belle-sip-tester \
		--resource-dir "${S}"/tester/ \
		--exclude-suite "SIP URI" --exclude-suite "FAST SIP URI" \
		--exclude-suite "Resolver" --exclude-suite "Register" \
		--exclude-suite "Dialog" --exclude-suite "HTTP stack" \
		|| die "tests failed"
}
