# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="carton carton-git-lwt carton-lwt carton-miou"

inherit dune git-r3

DESCRIPTION="Implementation of PACKv2 file in OCaml"
HOMEPAGE="https://github.com/robur-coop/carton"
EGIT_REPO_URI="https://github.com/robur-coop/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bstr:0=[ocamlopt?]
	dev-ml/cachet:0=[ocamlopt?]
	dev-ml/checkseum:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/decompress:0=[ocamlopt?]
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/duff:0=[ocamlopt?]
	dev-ml/flux:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/fpath:0=
	dev-ml/hxd:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/miou:0=[ocamlopt?]
	dev-ml/ohex:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/progress:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt )"
