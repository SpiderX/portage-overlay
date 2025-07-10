# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

MY_PN="${PN//1/-1}"
CLPACKAGE="${MY_PN}"
CLSYSTEMS="${MY_PN}"

DESCRIPTION="Common lisp implementation of unicode normalization functions"
HOMEPAGE="https://github.com/sabracrolleton/uax-15"
EGIT_REPO_URI="https://github.com/sabracrolleton/uax-15.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # tests not ready

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/split-sequence
	dev-lisp/uiop"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/parachute )"

DOCS=( {CHANGELOG,README}.md )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :uax-15)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/uax-15
	doins -r unicode-15-data
}
