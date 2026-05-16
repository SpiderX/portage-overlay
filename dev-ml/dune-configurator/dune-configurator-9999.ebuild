# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dune-configurator"

inherit dune edo git-r3

DESCRIPTION="Helper library for gathering system configuration"
HOMEPAGE="https://github.com/ocaml/dune"
EGIT_REPO_URI="https://github.com/ocaml/dune.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # tests in main dune package

DEPEND="dev-ml/csexp:0=[ocamlopt?]"
RDEPEND="${DEPEND}
	>=dev-ml/dune-3.20:0=
	dev-ml/pp:=[ocamlopt?]"
BDEPEND="test? ( dev-ml/utop )"

src_prepare() {
	default

	# don't use vendored libs
	edo rm -rf vendor/csexp
	edo rm -rf vendor/pp
}

src_configure() { :; }

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
