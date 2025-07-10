# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A Simple Test Framework In Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.stefil"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.stefil.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/slime"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/uiop )"

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
