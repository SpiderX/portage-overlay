# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Customizable partial evaluation for Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.partial-eval"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.partial-eval.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="test" # build error

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-logger
	dev-lisp/slime
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-walker"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.partial-eval.test)" \
		|| die "test failed"
}
