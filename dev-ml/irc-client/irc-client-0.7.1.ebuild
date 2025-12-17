# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# irc-client-tls fails
DUNE_PKG_NAME="irc-client irc-client-lwt irc-client-lwt-ssl irc-client-unix"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Pure OCaml implementation of the Open Sound Control protocol"
HOMEPAGE="https://github.com/johnelse/ocaml-irc-client"
SRC_URI="https://github.com/johnelse/${MY_PN}/archive/${PN}.${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PN}.${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
RESTRICT="test" # dev-ml/ounit2 doesn't have ounit

RDEPEND="dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ocaml-ssl:0=[ocamlopt?]
	dev-ml/result:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
