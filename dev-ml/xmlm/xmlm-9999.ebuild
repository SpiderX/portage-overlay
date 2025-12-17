# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 opam

DESCRIPTION="Ocaml XML manipulation module"
HOMEPAGE="https://github.com/dbuenzli/xmlm"
EGIT_REPO_URI="https://github.com/dbuenzli/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-ml/topkg"

src_compile() {
	edo ocaml pkg/pkg.ml build --tests "$(usex test 'true' 'false')"
}

src_test() {
	edo ocaml pkg/pkg.ml test
}
