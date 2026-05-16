# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A Runtime lib for ppx_yojson_conv"
HOMEPAGE="https://github.com/janestreet/ppx_yojson_conv_lib"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="dev-ml/yojson:0=[ocamlopt?]"
