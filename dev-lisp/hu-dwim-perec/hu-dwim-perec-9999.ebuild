# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EDARCS_REPOSITORY="https://hub.darcs.net/hu.dwim/hu.dwim.presentation"

inherit common-lisp-3 darcs

DESCRIPTION="RDBMS based persistent CLOS, an object relational mapping (ORM)"
HOMEPAGE="https://hub.darcs.net/hu.dwim/hu.dwim.perec"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="test" # build error from rdbms

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/babel
	dev-lisp/cl-containers
	dev-lisp/cl-ppcre
	dev-lisp/contextl
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-computed-class
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-logger
	dev-lisp/hu-dwim-quasi-quote
	dev-lisp/hu-dwim-rdbms
	dev-lisp/hu-dwim-serializer
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-walker
	dev-lisp/iolib
	dev-lisp/ironclad
	dev-lisp/local-time
	dev-lisp/metacopy
	dev-lisp/parse-number
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.perec.test)" \
		|| die "test failed"
}
