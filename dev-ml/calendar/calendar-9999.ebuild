# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Ocaml library to handle dates and time"
HOMEPAGE="https://github.com/ocaml-community/calendar"
EGIT_REPO_URI="https://github.com/ocaml-community/${PN}.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/re:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
