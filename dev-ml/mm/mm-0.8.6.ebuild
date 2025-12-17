# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml multimedia library"
HOMEPAGE="https://github.com/savonet/ocaml-mm"
SRC_URI="https://github.com/savonet/${MY_PN}/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
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
