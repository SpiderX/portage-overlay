# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Virtual network interface and software bridge for Mirage"
HOMEPAGE="https://github.com/mirage/mirage-vnetif"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="test" # alcotest doesn't provide alcotest-lwt

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/mirage-net:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/mirage-time )"

src_compile() {
	# mirage-vnetif-stack needs tcpip, circular
	dune-compile ${PN}
}
