# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Optimized Pattern Matching Library for Common Lisp"
HOMEPAGE="https://github.com/m2ym/optima"
EGIT_REPO_URI="https://github.com/m2ym/${PN}.git"

LICENSE="LLGPL-2.1"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/closer-mop
	dev-lisp/cl-ppcre"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiveam )"

PATCHES=( "${FILESDIR}/${PN}"-20150628-test.patch )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :optima)" \
		|| die "test failed"
}
