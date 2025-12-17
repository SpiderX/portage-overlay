# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml SDL2_image bindings to go with Tsdl"
HOMEPAGE="https://github.com/sanette/tsdl-image"
EGIT_REPO_URI="https://github.com/sanette/${PN}.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" # Assertion failed

RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]
	dev-ml/tsdl:0=[ocamlopt?]
	media-libs/sdl2-image"
BDEPEND="dev-ml/dune-configurator"
