# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Generic purpose logger utility"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.logger"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.logger.git"

LICENSE="MIT-0"
SLOT="0"
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
