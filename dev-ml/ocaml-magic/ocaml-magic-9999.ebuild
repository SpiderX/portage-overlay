# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools findlib git-r3

DESCRIPTION="OCaml bindings to libmagic"
HOMEPAGE="https://github.com/Chris00/ocaml-magic"
EGIT_REPO_URI="https://github.com/Chris00/${PN}.git"

LICENSE="LGPL-2"
SLOT="0/${PV}"

DOCS=( ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	einstalldocs
	findlib_src_install
}
