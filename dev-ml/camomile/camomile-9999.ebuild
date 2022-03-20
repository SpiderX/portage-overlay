# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/yoriyuki/${PN^}.git"

inherit dune git-r3

DESCRIPTION="A Unicode library for OCaml"
HOMEPAGE="https://github.com/yoriyuki/Camomile"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"

src_prepare() {
	default

	rm LICENSE.md || die "rm failed"

	# Specify version
	sed -i "/^(name camomile)/i(version ${PV})" dune-project \
		|| die "sed failed"
}
