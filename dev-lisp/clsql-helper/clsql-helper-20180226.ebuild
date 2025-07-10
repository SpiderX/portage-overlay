# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="846b67a26906da5ea2cff790a36a4cb2f496a528"

DESCRIPTION="A Common Lisp library to smooth some of CLSQLs rough edges"
HOMEPAGE="https://github.com/AccelerationNet/clsql-helper"
SRC_URI="https://github.com/AccelerationNet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
