# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Heterogenous maps over a GADT"
HOMEPAGE="https://github.com/hannesm/gmap"
SRC_URI="https://github.com/hannesm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest
		dev-ml/fmt )"
