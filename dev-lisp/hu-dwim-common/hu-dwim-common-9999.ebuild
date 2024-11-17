# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.common.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp package with code shared by all hu.dwim projects"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.common"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc"

RDEPEND="dev-lisp/alexandria
	dev-lisp/anaphora
	dev-lisp/closer-mop
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common-lisp
	dev-lisp/iterate
	dev-lisp/metabang-bind
	doc? ( dev-lisp/hu-dwim-presentation )"
