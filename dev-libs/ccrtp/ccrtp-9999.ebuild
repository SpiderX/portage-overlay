# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://git.savannah.gnu.org/git/${PN}.git"

inherit autotools git-r3 flag-o-matic

DESCRIPTION="GNU ccRTP - Implementation of the IETF real-time transport protocol"
HOMEPAGE="https://www.gnu.org/software/ccrtp/"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug doc static-libs"

RDEPEND="dev-cpp/commoncpp2:0=
	dev-libs/libgcrypt:0=
	dev-libs/ucommon:0="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-text/doxygen )"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	append-cxxflags -std=c++11

	econf "$(use_enable debug)" "$(use_enable static-libs static)"
}

src_install() {
	default

	find "${D}" -name '*.la' -delete || die "find failed"
}
