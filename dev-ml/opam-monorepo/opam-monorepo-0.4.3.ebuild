# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo

DESCRIPTION="Assemble and manage fully vendored Dune repositories"
HOMEPAGE="https://github.com/tarides/opam-monorepo"
SRC_URI="https://github.com/tarides/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-ml/opam:0=[ocamlopt?]"
BDEPEND="virtual/pkgconfig
	test? ( dev-vcs/git )"

src_test() {
	# tests invoke opam-monorepo, which requires an initialized OPAM root
	# and a named current switch (path switch is not recognized)
	export OPAMROOT="${T}/opam"
	edo git config --global user.email "you@example.com"
	edo git config --global user.name "Your Name"
	edo opam init --bare -n --no-opamrc --disable-sandboxing
	edo opam switch create "portage" ocaml-system --yes
	dune_src_test
}
