# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo opam

DESCRIPTION="CommonMark parser and renderer for OCaml"
HOMEPAGE="https://github.com/dbuenzli/cmarkit"
SRC_URI="https://github.com/dbuenzli/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="test" # needs b0

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]"
DEPEND="${RDEPEND}
	dev-ml/findlib
	dev-ml/ocamlbuild
	dev-ml/topkg"

src_prepare() {
	default

	# compatibility with cmdliner-1.3
	sed -i 's/Cmd\.make/Cmd.v/g' src/tool/cmd_{commonmark,html,latex,locs}.ml \
		|| die "sed failed"
}

src_compile() {
	edo ocaml pkg/pkg.ml build
}
