# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mm"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

inherit dune git-r3

DESCRIPTION="OCaml multimedia library"
HOMEPAGE="https://github.com/savonet/ocaml-mm"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="alsa ao ffmpeg gstreamer mad +ocamlopt ogg oss pulseaudio sdl theora v4l"

RDEPEND="alsa? ( dev-ml/ocaml-alsa:=[ocamlopt?] )
	ao? ( dev-ml/ocaml-ao:=[ocamlopt?] )
	ffmpeg? ( dev-ml/ocaml-ffmpeg:=[ocamlopt?] )
	gstreamer? ( dev-ml/ocaml-gstreamer:=[ocamlopt?] )
	mad? ( dev-ml/ocaml-mad:=[ocamlopt?] )
	ogg? ( dev-ml/ocaml-ogg:=[ocamlopt?] )
	pulseaudio? ( dev-ml/ocaml-pulseaudio:=[ocamlopt?] )
	sdl? ( dev-ml/ocamlsdl:=[ocamlopt?] )
	theora? ( dev-ml/ocaml-theora:=[ocamlopt?] )"
BDEPEND="dev-ml/dune-configurator:0="
