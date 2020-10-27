# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

DESCRIPTION="Extensible binary data format, like JSON but faster"
HOMEPAGE="https://github.com/ocaml-community/biniou"
SRC_URI="https://github.com/ocaml-community/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	dev-ml/easy-format:=[ocamlopt?]"
BDEPEND="${RDEPEND}
	dev-ml/dune:="

DOCS=( {CHANGES,README}.md )
