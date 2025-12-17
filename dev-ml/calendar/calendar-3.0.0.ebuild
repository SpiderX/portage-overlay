# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Ocaml library to handle dates and time"
HOMEPAGE="https://github.com/ocaml-community/calendar"
SRC_URI="https://github.com/ocaml-community/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/re:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
