# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml interface for Lastfm"
HOMEPAGE="https://github.com/savonet/ocaml-lastfm"
EGIT_REPO_URI="https://github.com/savonet/ocaml-lastfm.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

# dev-ml/ocamlnet:0=[ocamlopt?] no OCaml 5 support
RDEPEND="dev-ml/xmlplaylist:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]"
