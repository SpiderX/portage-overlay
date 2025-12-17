# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Composable concurrency primitives for OCaml"
HOMEPAGE="https://github.com/robur-coop/miou"
SRC_URI="https://github.com/robur-coop/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5.0.0:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/digestif
		dev-ml/dns
		dev-ml/dscheck
		dev-ml/happy-eyeballs
		dev-ml/hxd
		dev-ml/ipaddr
		dev-ml/logs
		dev-ml/mirage-crypto
		dev-ml/mtime )"
