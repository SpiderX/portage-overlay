# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="posix-socket"

inherit dune

MY_PN="ocaml-${PN/-socket/}"

DESCRIPTION="OCaml bindings for posix sockets"
HOMEPAGE="https://github.com/savonet/ocaml-posix"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/${PN}.${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PN}.${PV}"

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
