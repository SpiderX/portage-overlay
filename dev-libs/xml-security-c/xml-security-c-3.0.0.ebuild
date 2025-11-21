# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Apache C++ XML security libraries"
HOMEPAGE="https://shibboleth.atlassian.net/wiki/spaces/SP3/pages/2067398783/XML-Security-C"
SRC_URI="https://shibboleth.net/downloads/xml-security-c/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples static-libs"

RDEPEND="dev-libs/openssl:0=
	dev-libs/xerces-c"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	econf --with-openssl \
		"$(use_enable static-libs static)" \
		"$(use_enable debug)"
}

src_install() {
	default
	if use examples ; then
		docinto examples
		dodoc xsec/samples/*.cpp
	fi
	find "${D}" -name '*.la' -delete || die "find failed"
}
