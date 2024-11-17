# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3a698325983bb7449f39b3d2516c5652c2cfc38f"
MY_PN="${PN//-/.}"

DESCRIPTION="Generic purpose logger utility"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.logger"
SRC_URI="https://github.com/hu-dwim/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )" # no tests

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/bordeaux-threads
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/local-time
	dev-lisp/slime
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/hu-dwim-stefil )"
