# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="xenstore-tool xenstore_transport"

inherit dune

DESCRIPTION="Unix client tools for accessing xenstore"
HOMEPAGE="https://github.com/xapi-project/ocaml-xenstore-clients"
EGIT_REPO_URI="https://github.com/xapi-project/ocaml-xenstore-clients.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # needs xenfs

RDEPEND="dev-ml/camlp-streams[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/xenstore:0=[ocamlopt?]"
BDEPEND="dev-ml/findlib
	test? ( dev-ml/ounit2 )"
