# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Property fuzzing for OCaml"
HOMEPAGE="https://github.com/stedolan/crowbar"
SRC_URI="https://github.com/stedolan/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/afl-persistent:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/calendar
		dev-ml/fpath
		dev-ml/pprint
		dev-ml/uucp
		dev-ml/uunf
		dev-ml/uutf )"
