# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/ocaml-community/${PN}.git"

inherit dune git-r3

DESCRIPTION="Extensible binary data format, like JSON but faster"
HOMEPAGE="https://github.com/ocaml-community/biniou"
SRC_URI=""

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	dev-ml/easy-format:=[ocamlopt?]"
BDEPEND="${RDEPEND}
	dev-ml/dune:="

DOCS=( {CHANGES,README}.md )
