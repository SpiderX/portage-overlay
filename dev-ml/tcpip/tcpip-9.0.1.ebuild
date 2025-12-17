# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml TCP/IP networking stack, used in MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-tcpip"
SRC_URI="https://github.com/mirage/mirage-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ipv6 +ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/arp:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/ethernet:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lru:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/lwt-dllist:0=[ocamlopt?]
	dev-ml/metrics:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-net:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/randomconv:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/mirage-vnetif
		dev-ml/pcap-format )"

src_prepare() {
	default

	! use ipv6 && eapply "${FILESDIR}/${PN}"-9.0.1-test-ipv6.patch
}
