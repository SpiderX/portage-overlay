# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="chrome-trace"

inherit dune edo git-r3

DESCRIPTION="Chrome trace event generation library"
HOMEPAGE="https://github.com/ocaml/dune"
EGIT_REPO_URI="https://github.com/ocaml/dune.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" # tests in main dune package

RDEPEND="dev-ml/dune:0="

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
