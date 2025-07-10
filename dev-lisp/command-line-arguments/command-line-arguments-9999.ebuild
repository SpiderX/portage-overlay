# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Trivial command-line argument parsing library for Common Lisp"
HOMEPAGE="https://github.com/fare/command-line-arguments"
EGIT_REPO_URI="https://github.com/fare/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # build fails

RDEPEND="dev-lisp/uiop"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/alexandria
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :command-line-arguments)" \
		|| die "test failed"
}
