# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.computed-class.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Constraint based change propagation with CLOS integration"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.computed-class"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-logger
	dev-lisp/hu-dwim-syntax-sugar
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/hu-dwim-stefil
		dev-lisp/uiop )"

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
