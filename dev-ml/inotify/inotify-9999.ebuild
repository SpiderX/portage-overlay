# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="inotify inotify-eio"

inherit dune git-r3

DESCRIPTION="OCaml bindings for inotify"
HOMEPAGE="https://github.com/whitequark/ocaml-inotify"
EGIT_REPO_URI="https://github.com/whitequark/ocaml-inotify.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/iomux:0=[ocamlopt?]
	dev-ml/lwt:=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ocaml-fileutils
		dev-ml/ounit2 )"
