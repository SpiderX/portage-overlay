# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Manipulate, parse and generate OCaml compiler version strings"
HOMEPAGE="https://github.com/ocurrent/ocaml-version"
SRC_URI="https://github.com/ocurrent/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest )"
