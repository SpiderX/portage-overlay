# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A plugin to generate Yojson conversion functions"
HOMEPAGE="https://github.com/janestreet/ppx_yojson_conv"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5.3.0:0=[ocamlopt?]
	dev-ml/base:0=[ocamlopt?]
	dev-ml/ppx_js_style:0=[ocamlopt?]
	dev-ml/ppx_yojson_conv_lib:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ppx_compare
		dev-ml/ppx_jane )"
