# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Library providing hexadecimal converters"
HOMEPAGE="https://github.com/mirage/ocaml-hex"
EGIT_REPO_URI="https://github.com/mirage/ocaml-hex.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]"
