# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml interface for Lastfm"
HOMEPAGE="https://github.com/savonet/ocaml-lastfm"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

# dev-ml/ocamlnet:0=[ocamlopt?] no OCaml 5 support
RDEPEND="dev-ml/xmlplaylist:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]"
