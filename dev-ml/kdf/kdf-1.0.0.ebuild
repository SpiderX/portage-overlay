# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Key deriving functions in OCaml"
HOMEPAGE="https://github.com/robur-coop/kdf"
SRC_URI="https://github.com/robur-coop/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/digestif:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/ohex )"
