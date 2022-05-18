# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ESVN_REPO_URI="https://svn.apache.org/repos/asf/santuario/xml-security-cpp/trunk"

inherit autotools subversion

DESCRIPTION="Apache C++ XML security libraries"
HOMEPAGE="https://santuario.apache.org"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="debug examples nss static-libs xalan"

RDEPEND="dev-libs/openssl:0=
	dev-libs/xerces-c
	nss? ( dev-libs/nss )
	xalan? ( dev-libs/xalan-c )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,NOTICE}.txt )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-openssl \
		"$(use_enable static-libs static)" \
		"$(use_enable debug)" \
		"$(use_with xalan)" \
		"$(use_with nss)"
}

src_install() {
	default
	if use examples ; then
		docinto examples
		dodoc xsec/samples/*.cpp
	fi
}
