# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="A real-time web log analyzer and interactive viewer that runs in a terminal"
HOMEPAGE="http://goaccess.io"
SRC_URI="http://tar.goaccess.io/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="btree debug geoip getline tokyocabinet ssl unicode"

RDEPEND="sys-libs/ncurses:=[unicode?]
	geoip? ( dev-libs/geoip )
	!tokyocabinet? ( dev-libs/glib:2 )
	tokyocabinet? (
		dev-db/tokyocabinet
		btree? (
			app-arch/bzip2
			sys-libs/zlib
		)
	)
	ssl? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="btree? ( tokyocabinet )"

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable geoip) \
		$(use_enable unicode utf8) \
		$(use_enable tokyocabinet tcb) \
		$(use_enable btree bzip) \
		$(use_enable btree zlib) \
		$(use_with getline) \
		$(use_with ssl openssl) \
		$(usex tokyocabinet "--enable-tcb=$(usex btree btree memhash)" '')
}

pkg_preinst() {
	# Change path to GeoIP bases in config
	sed -e s':/usr/local:/usr:' -i "${D}"/etc/goaccess.conf || die "sed failed for goaccess.conf"
}
