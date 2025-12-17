# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="posix-socket"

inherit dune git-r3

DESCRIPTION="OCaml bindings for posix sockets"
HOMEPAGE="https://github.com/savonet/ocaml-posix"
EGIT_REPO_URI="https://github.com/savonet/ocaml-posix.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]
	dev-ml/unix-errno:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/ocaml-process
		dev-ml/ounit2 )"
