# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp DEFCLASS* for less boilerplate"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.defclass-star"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.defclass-star.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )" # 7 tests, 23 assertions, 4 failures

RDEPEND="dev-lisp/contextl
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/hu-dwim-common
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.defclass-star)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/hu-dwim-defclass-star
	doins version.sexp
}
