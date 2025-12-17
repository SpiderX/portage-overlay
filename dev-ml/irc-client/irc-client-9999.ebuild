# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# irc-client-tls fails
DUNE_PKG_NAME="irc-client irc-client-lwt irc-client-lwt-ssl irc-client-unix"

inherit dune git-r3

DESCRIPTION="Pure OCaml implementation of the Open Sound Control protocol"
HOMEPAGE="https://github.com/johnelse/ocaml-irc-client"
EGIT_REPO_URI="https://github.com/johnelse/ocaml-irc-client.git"

LICENSE="MIT"
SLOT="0/${PV}"
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
