# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GNU ccRTP - Implementation of the IETF real-time transport protocol"
HOMEPAGE="https://www.gnu.org/software/ccrtp"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug doc static-libs"

RDEPEND="dev-cpp/commoncpp2:0=
	dev-libs/libgcrypt:0=
	>=dev-libs/ucommon-6.2.2:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	econf "$(use_enable debug)" "$(use_enable static-libs static)"
}
