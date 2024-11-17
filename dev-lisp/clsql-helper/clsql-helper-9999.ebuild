# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/AccelerationNet/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp library to smooth some of CLSQLs rough edges"
HOMEPAGE="https://github.com/AccelerationNet/clsql-helper"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # CLSQL-HELPER-TEST::TEST-RECENCY-CHECKS - ERRORS

RDEPEND="dev-lisp/access
	dev-lisp/alexandria
	dev-lisp/cl-interpol
	dev-lisp/closer-mop
	dev-lisp/cl-ppcre
	dev-lisp/clsql
	dev-lisp/collectors
	dev-lisp/iterate
	dev-lisp/md5
	dev-lisp/symbol-munger"
BDEPEND="test? ( dev-lisp/lisp-unit2 )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :clsql-helper)" \
		|| die "test failed"
}
