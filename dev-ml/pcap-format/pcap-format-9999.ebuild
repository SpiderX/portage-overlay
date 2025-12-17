# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml code for generating and analysing pcap files"
HOMEPAGE="https://github.com/mirage/ocaml-pcap"
EGIT_REPO_URI="https://github.com/mirage/ocaml-pcap.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" # dev-ml/ounit2 doesn't have ounit

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]"
