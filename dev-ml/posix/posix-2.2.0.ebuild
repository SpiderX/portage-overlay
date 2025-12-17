# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="posix-base posix-bindings posix-getopt posix-math2 posix-signal
	posix-socket-unix posix-time2 posix-types posix-uname"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml bindings to the various POSIX APIs"
HOMEPAGE="https://github.com/savonet/ocaml-posix"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]
	dev-ml/unix-errno:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/ocaml-process
		dev-ml/ounit2 )"
