# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="xenstore-tool xenstore_transport"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Unix client tools for accessing xenstore"
HOMEPAGE="https://github.com/xapi-project/ocaml-xenstore-clients"
SRC_URI="https://github.com/xapi-project/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="test" # needs xenfs

RDEPEND="dev-ml/camlp-streams[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/xenstore:0=[ocamlopt?]"
BDEPEND="dev-ml/findlib
	test? ( dev-ml/ounit2 )"
