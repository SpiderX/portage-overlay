# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="GNU Common C++ 2"
HOMEPAGE="http://www.gnu.org/software/commoncpp/"
SRC_URI="mirror://gnu/commoncpp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc gnutls ipv6 ssl static-libs"

DOCS=( ChangeLog COPYING.addendum )

RDEPEND="sys-libs/zlib:=
	ssl? ( !gnutls? ( dev-libs/openssl:0= )
		gnutls? ( net-libs/gnutls
			dev-libs/libgcrypt:0 ) )"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

PATCHES=( "${FILESDIR}"/1.8.1-autoconf-update.patch
	"${FILESDIR}"/1.8.1-configure_detect_netfilter.patch
	"${FILESDIR}"/1.8.0-glibc212.patch
	"${FILESDIR}"/1.8.1-fix-buffer-overflow.patch
	"${FILESDIR}"/1.8.1-parallel-build.patch
	"${FILESDIR}"/1.8.1-libgcrypt.patch
	"${FILESDIR}"/1.8.1-fix-c++14.patch
	"${FILESDIR}"/1.8.1-gnutls-3.4.patch
	"${FILESDIR}"/1.8.1-openssl-1.1.patch
	"${FILESDIR}"/1.8.1-fix-gcc9.patch
	"${FILESDIR}"/1.8.1-c++17.patch )

src_prepare() {
	default
	# needed for doxygen configure switch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with ipv6) \
		$(use_with ssl $(usex gnutls gnutls openssl)) \
		$(use_enable static-libs static) \
		$(use_with doc doxygen)
}

src_install() {
	use doc && local HTML_DOCS=( doc/html/. )
	default

	find "${D}" -name '*.la' -delete || die "find failed"
}
