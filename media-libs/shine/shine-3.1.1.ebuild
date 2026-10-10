# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit autotools

DESCRIPTION="Fixed-point mp3 encoding library"
HOMEPAGE="https://github.com/toots/shine"
SRC_URI="https://github.com/toots/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( ChangeLog )

BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-3.1.1-fix-c23-prototype.patch )

src_prepare() {
	default

	sed -i 's|^libdir=.*$|libdir=@libdir@|' shine.pc.in \
		|| die "sed failed for shine.pc.in"

	eautoreconf
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}
