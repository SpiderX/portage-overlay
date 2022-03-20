# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib toolchain-funcs

DESCRIPTION="OCaml interface to the GD graphics library"
HOMEPAGE="https://github.com/savonet/gd4o"
SRC_URI="https://api.github.com/repos/savonet/${PN}/tarball/5097a27 -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/gd[jpeg,png]
	media-libs/freetype:2
	media-libs/libpng:0=
	sys-libs/zlib:=
	virtual/jpeg:0"

S="${WORKDIR}/savonet-${PN}-5097a27"

src_prepare() {
	default

	sed -i '/CFLAGS/s/=/+=/' Makefile \
		|| die "sed failed for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
	use ocamlopt && emake CC="$(tc-getCC)" opt
}

src_test() {
	emake test
	use ocamlopt && emake test.opt
}

src_install() {
	findlib_src_install
	einstalldocs
}
