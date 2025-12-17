# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME=lablgtk3

inherit dune git-r3

DESCRIPTION="OCaml bindings to GTK-3"
HOMEPAGE="https://github.com/garrigue/lablgtk"
EGIT_REPO_URI="https://github.com/garrigue/${PN}.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="3/${PV}"
IUSE="+ocamlopt sourceview"

DEPEND="app-text/gtkspell:3=
	dev-ml/cairo2:0=[ocamlopt?]
	dev-ml/camlp-streams:=[ocamlopt?]
	x11-libs/gtk+:3=[X]
	x11-libs/gtksourceview:3.0="
RDEPEND="${DEPEND}"
PDEPEND="sourceview? ( dev-ml/lablgtk-sourceview:3 )"
