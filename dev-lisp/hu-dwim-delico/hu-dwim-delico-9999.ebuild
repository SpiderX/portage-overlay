# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Delimited, interpreted shift-reset continuation"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.delico"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.delico.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )" # 47 tests, 185 assertions, 1 failure

RDEPEND="dev-lisp/contextl
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-walker
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil
		dev-lisp/hu-dwim-util )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.delico)" \
		|| die "test failed"
}
