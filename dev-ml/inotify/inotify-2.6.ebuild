# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="inotify inotify-eio"

inherit dune

DESCRIPTION="OCaml bindings for inotify"
HOMEPAGE="https://github.com/whitequark/ocaml-inotify"
SRC_URI="https://github.com/whitequark/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/iomux:0=[ocamlopt?]
	dev-ml/lwt:=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ocaml-fileutils
		dev-ml/ounit2 )"
