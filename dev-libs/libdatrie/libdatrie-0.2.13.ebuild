# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Double-Array Trie Library"
HOMEPAGE="https://github.com/tlwg/libdatrie"
SRC_URI="https://github.com/tlwg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}"
BDEPEND="virtual/libiconv
	virtual/pkgconfig"

src_prepare() {
	default

	# set version (build-aux/git-version-gen)
	echo "${PV}" > VERSION

	eautoreconf
}

src_configure() {
	econf --disable-doxygen-doc
}

src_install() {
	default

	rm -f "${ED}"/usr/"$(get_libdir)"/*.la || die "rm failed"
}
