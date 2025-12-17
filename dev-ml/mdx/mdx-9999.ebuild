# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Execute code blocks inside your documentation"
HOMEPAGE="https://github.com/realworldocaml/mdx"
EGIT_REPO_URI="https://github.com/realworldocaml/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/astring:0=
	dev-ml/camlp-streams[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/csexp:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[cli,ocamlopt?]
	dev-ml/ocaml-version[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/result:0=[ocamlopt?]"
DEPEND="${RDEPEND}
	dev-ml/cppo:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/lwt )"
