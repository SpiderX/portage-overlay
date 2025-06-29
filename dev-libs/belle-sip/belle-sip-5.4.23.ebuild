# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SIP (RFC3261) implementation"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belle-sip"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test zeroconf"
RESTRICT="test" # tester doesn't see sip grammar
PROPERTIES="test_network"

RDEPEND="dev-cpp/belr
	net-libs/bctoolbox[test?]
	sys-libs/zlib:=
	zeroconf? ( net-dns/avahi[mdnsresponder-compat] )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-cpp/cpp-httplib:0= )"

PATCHES=( "${FILESDIR}/${PN}"-5.4.23-CMakeLists.txt.patch )

src_prepare() {
	# link agains system httplib
	sed -i  -e '/add_subdirectory(cpp-httplib)/d' \
		-e "s/PUBLIC httplib/PRIVATE \${HTTPLIB_LIBRARY}/" \
		tester/CMakeLists.txt || die "sed failed for CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_MDNS="$(usex zeroconf)"
		-DENABLE_STRICT=NO
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
