# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Framework to work with syntax sugars in Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.syntax-sugar"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.syntax-sugar.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-walker
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/hu-dwim-stefil
		dev-lisp/uiop )"

PATCHES=( "${FILESDIR}/${PN}"-20220821-test.patch )

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
