# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Read metadata from various file formats"
HOMEPAGE="https://github.com/savonet/ocaml-metadata"
EGIT_REPO_URI="https://github.com/savonet/ocaml-metadata.git"

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE="+ocamlopt"
