# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="DigiDoc digital signature library"
HOMEPAGE="https://github.com/open-eid/libdigidoc http://id.ee"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="doc libressl +utils"

RDEPEND="dev-libs/libxml2:2
	dev-libs/opensc
	sys-libs/zlib:0=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
DEPEND="${RDEPEND}
	virtual/libiconv"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_configure() {
	append-cppflags "-DOF=_Z_OF"

	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DDOXYGEN_FOUND="$(usex doc yes no)"
		-DBUILD_TOOLS="$(usex utils)"
	)
	cmake-utils_src_configure
}
