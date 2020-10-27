# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/savonet/${PN}.git"
EGIT_SUBMODULES=()

inherit dune git-r3

DESCRIPTION="OCaml bindings to ffmpeg"
HOMEPAGE="https://github.com/savonet/ocaml-ffmpeg"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"
RESTRICT="test" # fails

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	media-video/ffmpeg:="
BDEPEND="${RDEPEND}
	dev-ml/dune:=
	dev-ml/dune-configurator:="

DOCS=( CHANGES README.md )

src_install() {
	dune_src_install ffmpeg-avcodec ffmpeg-avdevice ffmpeg-avfilter \
		ffmpeg-av ffmpeg-avutil ffmpeg ffmpeg-swresample ffmpeg-swscale
}
