# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mimic mimic-happy-eyeballs"

inherit dune git-r3

DESCRIPTION="A simple protocol dispatcher"
HOMEPAGE="https://github.com/dinosaure/mimic"
EGIT_REPO_URI="https://github.com/dinosaure/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/dns-client:0=[ocamlopt?]
	dev-ml/happy-eyeballs:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt
		dev-ml/bigstringaf
		dev-ml/cstruct
		dev-ml/ke )"
