# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.def.git"

inherit common-lisp-3 git-r3

DESCRIPTION="One macro to define them all"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.def"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/alexandria
	dev-lisp/anaphora
	dev-lisp/bordeaux-threads
	dev-lisp/cl-l10n
	dev-lisp/contextl
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-delico
	dev-lisp/iterate
	dev-lisp/metabang-bind
	dev-lisp/slime
	dev-lisp/trivial-garbage
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/hu-dwim-stefil
		dev-lisp/optima )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.def)" \
		|| die "test failed"
}
