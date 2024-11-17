# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.uri.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Uniform Resource Identifier in Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.uri"

LICENSE="MIT-0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/babel
	dev-lisp/cl-ppcre
	dev-lisp/hu-dwim-asdf
	dev-lisp/iolib"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/hu-dwim-stefil
		dev-lisp/uiop )"

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
