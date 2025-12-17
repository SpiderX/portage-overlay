# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Address Resolution Protocol purely in OCaml"
HOMEPAGE="https://github.com/mirage/arp"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/ethernet:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lru:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/bos
		dev-ml/mirage-vnetif )"
