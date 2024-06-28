# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tlwg/${PN}.git"

inherit autotools git-r3

DESCRIPTION="A a set of Thai language support routines"
HOMEPAGE="https://github.com/tlwg/libthai"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="dev-libs/libdatrie"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf --disable-doxygen-doc
}

src_install() {
	default

	rm -f "${ED}"/usr/"$(get_libdir)"/*.la || die "rm failed"
}
