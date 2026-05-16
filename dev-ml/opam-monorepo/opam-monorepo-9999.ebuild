# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo git-r3

DESCRIPTION="Assemble and manage fully vendored Dune repositories"
HOMEPAGE="https://github.com/tarides/opam-monorepo"
EGIT_REPO_URI="https://github.com/tarides/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # need proper setup

RDEPEND="dev-ml/opam:0=[ocamlopt?]"
BDEPEND="virtual/pkgconfig"

src_test() {
	edo git init > /dev/null
	edo git config user.email "you@example.com"
	edo git config user.name "Your Name"
	edo opam init -n --no-opamrc --disable-sandboxing
	dune_src_test
}
