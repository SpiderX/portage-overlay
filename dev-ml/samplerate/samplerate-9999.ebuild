# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml bindings to libsamplerate"
HOMEPAGE="https://github.com/savonet/ocaml-samplerate"
EGIT_REPO_URI="https://github.com/savonet/ocaml-samplerate.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="media-libs/libsamplerate"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"
