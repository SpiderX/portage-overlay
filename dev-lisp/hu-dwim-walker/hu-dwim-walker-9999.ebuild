# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Customizable code walker for Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.walker"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.walker.git"

LICENSE="BSD"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="test" # HU.DWIM.DELICO.TEST not found

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/alexandria
	dev-lisp/anaphora
	dev-lisp/closer-mop
	dev-lisp/contextl
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/metabang-bind
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.delico.test)" \
		|| die "test failed"
}
