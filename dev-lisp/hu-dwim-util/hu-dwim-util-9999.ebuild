# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Various utilities for Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.util"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.util.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="test" # HU.DWIM.DEF.NAMESPACE not found

RDEPEND="dev-lisp/babel
	dev-lisp/bordeaux-threads
	dev-lisp/cl-l10n
	dev-lisp/closer-mop
	dev-lisp/cl-ppcre
	dev-lisp/command-line-arguments
	dev-lisp/cxml
	dev-lisp/drakma
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-delico
	dev-lisp/hu-dwim-logger
	dev-lisp/hu-dwim-partial-eval
	dev-lisp/hu-dwim-perec
	dev-lisp/hu-dwim-quasi-quote
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-web-server
	dev-lisp/hu-dwim-walker
	dev-lisp/iolib
	dev-lisp/slime
	dev-lisp/uiop
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.util.test)" \
		|| die "test failed"
}
