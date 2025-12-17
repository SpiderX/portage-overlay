# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="posix-base posix-bindings posix-getopt posix-math2 posix-signal
	posix-socket-unix posix-time2 posix-types posix-uname"

inherit dune git-r3

DESCRIPTION="OCaml bindings to the various POSIX APIs"
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
