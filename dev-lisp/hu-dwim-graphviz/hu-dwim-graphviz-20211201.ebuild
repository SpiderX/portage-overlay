# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="31522ca8b9a04d535b7cec20ef24d8bf3b26d52b"
MY_PN="${PN//-/.}"

DESCRIPTION="Graphviz layouting using CFFI bindings"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.graphviz"
SRC_URI="https://github.com/hu-dwim/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
