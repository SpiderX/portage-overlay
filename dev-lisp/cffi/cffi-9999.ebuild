# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/cffi/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="The Common Foreign Function Interface"
HOMEPAGE="https://github.com/cffi/cffi"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # tests failed: FSBV.WFO, FSBV.MAKEPAIR.1, FSBV.MAKEPAIR.2

RDEPEND="dev-lisp/alexandria
	dev-lisp/babel
	dev-lisp/cl-json
	dev-lisp/cl-ppcre
	dev-lisp/trivial-features
	dev-lisp/uiop"
BDEPEND="test? ( dev-lisp/bordeaux-threads )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cffi)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/cffi/grovel
	doins grovel/common.h
}
