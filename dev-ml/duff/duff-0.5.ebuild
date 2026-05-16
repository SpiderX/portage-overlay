# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Pure OCaml implementation of libXdiff"
HOMEPAGE="https://github.com/mirage/duff"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/fmt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/bigstringaf
		dev-ml/crowbar
		dev-ml/hxd )"
