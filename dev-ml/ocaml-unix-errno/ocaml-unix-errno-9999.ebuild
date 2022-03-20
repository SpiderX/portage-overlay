# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="unix-errno"
EGIT_REPO_URI="https://github.com/xapi-project/${PN}.git"

inherit dune git-r3

DESCRIPTION="Unix errno types, maps, and support for OCaml"
HOMEPAGE="https://github.com/xapi-project/ocaml-unix-errno"
SRC_URI=""

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]"

src_prepare() {
	default

	rm LICENSE || die "rm failed"
}
