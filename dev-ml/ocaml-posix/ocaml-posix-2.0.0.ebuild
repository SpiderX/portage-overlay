# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="posix-bindings posix-base posix-signal posix-types
	posix-time2 posix-socket posix-socket-unix posix-uname posix-getopt"

inherit dune

DESCRIPTION="OCaml bindings for posix sockets"
HOMEPAGE="https://github.com/savonet/ocaml-posix"
SRC_URI="https://github.com/savonet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]
	dev-ml/ocaml-unix-errno:=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator:0="

src_prepare() {
	default

	rm LICENSE || die "rm failed"
}
