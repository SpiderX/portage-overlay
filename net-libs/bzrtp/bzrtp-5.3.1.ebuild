# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Media Path Key Agreement for Unicast Secure RTP"
HOMEPAGE="https://gitlab.linphone.org/BC/public/bzrtp"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc sqlite test"
RESTRICT="!test? ( test )"

RDEPEND="net-libs/bctoolbox[test?]
	sqlite? ( dev-db/sqlite:3
		dev-libs/libxml2:2 )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DOC="$(usex doc)"
		-DENABLE_STRICT=NO
		-DENABLE_UNIT_TESTS="$(usex test)"
		-DENABLE_ZIDCACHE="$(usex sqlite)"
	)

	cmake_src_configure
}
