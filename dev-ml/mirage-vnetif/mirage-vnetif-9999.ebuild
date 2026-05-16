# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# mirage-vnetif-stack https://github.com/mirage/mirage-vnetif/commit/a11462b1f0a283012f4d3f9a51ca481030bb8b12
DUNE_PKG_NAME="mirage-vnetif"

inherit dune git-r3

DESCRIPTION="Virtual network interface and software bridge for Mirage"
HOMEPAGE="https://github.com/mirage/mirage-vnetif"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # no tests for mirage-vnetif

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/mirage-net:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
