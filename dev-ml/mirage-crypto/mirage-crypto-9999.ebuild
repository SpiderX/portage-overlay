# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mirage-crypto mirage-crypto-ec mirage-crypto-pk
	mirage-crypto-rng mirage-crypto-rng-mirage mirage-crypto-rng-miou-unix"

inherit dune git-r3

DESCRIPTION="Simple symmetric cryptography for the modern age"
HOMEPAGE="https://github.com/mirage/mirage-crypto"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/digestif:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/eqaf:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/mirage-unix:0=[ocamlopt?]
	dev-ml/miou:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/zarith:0=[ocamlopt?]"
DEPEND="dev-libs/gmp:0=
	${RDEPEND}"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/alcotest
		dev-ml/asn1-combinators
		dev-ml/ohex
		dev-ml/ounit2
		dev-ml/ppx_deriving
		dev-ml/ppx_deriving_yojson
		dev-ml/randomconv
		dev-ml/yojson )"
