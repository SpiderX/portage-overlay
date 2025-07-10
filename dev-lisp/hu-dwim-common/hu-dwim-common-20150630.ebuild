# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="38949223e9d67d0f8ae3052d2c7738b0c58ca973"
MY_PN="${PN//-/.}"

DESCRIPTION="Common Lisp package with code shared by all hu.dwim projects"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.common"
SRC_URI="https://github.com/hu-dwim/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-lisp/alexandria
	dev-lisp/anaphora
	dev-lisp/closer-mop
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common-lisp
	dev-lisp/iterate
	dev-lisp/metabang-bind
	doc? ( dev-lisp/hu-dwim-presentation )"
