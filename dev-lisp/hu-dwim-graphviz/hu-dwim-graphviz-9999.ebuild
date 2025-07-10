# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Graphviz layouting using CFFI bindings"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.graphviz"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.graphviz.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )" # no tests

RDEPEND="dev-lisp/cffi
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/metabang-bind
	media-gfx/graphviz
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="virtual/pkgconfig
	test? ( dev-lisp/hu-dwim-stefil )"
