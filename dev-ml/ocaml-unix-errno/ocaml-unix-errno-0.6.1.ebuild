# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="unix-errno"

inherit dune

DESCRIPTION="Unix errno types, maps, and support for OCaml"
HOMEPAGE="https://github.com/xapi-project/ocaml-unix-errno"
SRC_URI="https://github.com/xapi-project/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]"

src_prepare() {
	default

	rm LICENSE || die "rm failed"
}
