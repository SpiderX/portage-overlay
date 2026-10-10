# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit autotools git-r3

DESCRIPTION="Fixed-point mp3 encoding library"
HOMEPAGE="https://github.com/toots/shine"
EGIT_REPO_URI="https://github.com/toots/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

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
