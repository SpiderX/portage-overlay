# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Execute code blocks inside your documentation"
HOMEPAGE="https://github.com/realworldocaml/mdx"
SRC_URI="https://github.com/realworldocaml/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
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
