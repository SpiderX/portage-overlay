# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="commoncpp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A class framework that was specifically designed for telephony applications"
HOMEPAGE="https://www.gnu.org/software/commoncpp/"
SRC_URI="https://git.savannah.gnu.org/cgit/commoncpp.git/snapshot/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cxx doc gnutls static-libs ssl test"
RESTRICT="!test? ( test )"

RDEPEND="ssl? ( !gnutls? ( dev-libs/openssl:0= )
		gnutls? ( net-libs/gnutls
			dev-libs/libgcrypt:0 ) )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-text/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS="$(usex doc)"
		-DBUILD_STDLIB="$(usex cxx)"
		-DBUILD_STATIC="$(usex static-libs)"
		-DCRYPTO_OPENSSL="$(usex ssl)"
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
}
