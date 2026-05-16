# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="A Runtime lib for ppx_yojson_conv"
HOMEPAGE="https://github.com/janestreet/ppx_yojson_conv_lib"
EGIT_REPO_URI="https://github.com/janestreet/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/yojson:0=[ocamlopt?]"
