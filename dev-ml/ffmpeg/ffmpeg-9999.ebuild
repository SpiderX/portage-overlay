# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ffmpeg-avcodec ffmpeg-avdevice ffmpeg-avfilter ffmpeg-av
	ffmpeg-avutil ffmpeg ffmpeg-swresample ffmpeg-swscale"

inherit dune git-r3

DESCRIPTION="OCaml bindings to ffmpeg"
HOMEPAGE="https://github.com/savonet/ocaml-ffmpeg"
EGIT_REPO_URI="https://github.com/savonet/ocaml-ffmpeg.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-video/ffmpeg:0="
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
