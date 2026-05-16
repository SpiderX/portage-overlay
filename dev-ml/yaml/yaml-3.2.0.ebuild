# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="yaml yaml-sexp"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml interface to the YAML 1.1 spec"
HOMEPAGE="https://github.com/avsm/ocaml-yaml"
SRC_URI="https://github.com/avsm/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bos
	dev-ml/ocaml-ctypes:0=[ocamlopt?]
	dev-ml/ppx_sexp_conv:0=[ocamlopt?]
	dev-ml/sexplib:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/ezjsonm
		dev-ml/fmt
		dev-ml/junit
		dev-ml/logs
		dev-ml/mdx )"
