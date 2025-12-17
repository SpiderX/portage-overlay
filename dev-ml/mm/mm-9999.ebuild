# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml multimedia library"
HOMEPAGE="https://github.com/savonet/ocaml-mm"
EGIT_REPO_URI="https://github.com/savonet/ocaml-mm.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="alsa ao ffmpeg gstreamer mad +ocamlopt pulseaudio sdl theora"

RDEPEND="alsa? ( dev-ml/alsa:0=[ocamlopt?] )
	ao? ( dev-ml/ao:0=[ocamlopt?] )
	ffmpeg? ( dev-ml/ffmpeg:0=[ocamlopt?] )
	gstreamer? ( dev-ml/gstreamer:0=[ocamlopt?] )
	mad? ( dev-ml/mad:0=[ocamlopt?] )
	pulseaudio? ( dev-ml/pulseaudio:0=[ocamlopt?] )
	sdl? ( dev-ml/ocamlsdl:0=[ocamlopt?] )
	theora? ( dev-ml/theora:0=[ocamlopt?] )"
BDEPEND="dev-ml/dune-configurator"
