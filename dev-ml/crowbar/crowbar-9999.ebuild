# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Property fuzzing for OCaml"
HOMEPAGE="https://github.com/stedolan/crowbar"
EGIT_REPO_URI="https://github.com/stedolan/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
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
