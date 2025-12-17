# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml advanced scheduler"
HOMEPAGE="https://github.com/savonet/ocaml-duppy"
EGIT_REPO_URI="https://github.com/savonet/ocaml-duppy.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt ssl"

RDEPEND="dev-ml/re:0=[ocamlopt?]
	ssl? ( dev-ml/ocaml-ssl:0=[ocamlopt?] )"
