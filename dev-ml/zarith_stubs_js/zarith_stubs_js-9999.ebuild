# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Javascripts stubs for the Zarith library"
HOMEPAGE="https://github.com/janestreet/zarith_stubs_js"
EGIT_REPO_URI="https://github.com/janestreet/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # diff fails

BDEPEND="test? ( dev-ml/ppx_jane )"
