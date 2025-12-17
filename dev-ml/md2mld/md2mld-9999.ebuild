# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Little cli to convert md files into mld files"
HOMEPAGE="https://github.com/mseri/md2mld"
EGIT_REPO_URI="https://github.com/mseri/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/omd:0=[ocamlopt?]"
