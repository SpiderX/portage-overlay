# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="2d64d4183bfc91824068cd4cf3414238d3c00fe5"

DESCRIPTION="A common lisp library providing easy csv reading and writing"
HOMEPAGE="https://github.com/AccelerationNet/cl-csv"
SRC_URI="https://github.com/AccelerationNet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # CL-CSV-TEST::DATA-WITH-WHITESPACE-TRIM - FAILED

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-interpol
	dev-lisp/clsql-helper
	dev-lisp/data-table
	dev-lisp/iterate"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lisp-unit2 )"

src_prepare() {
	default

	sed -i  -e 's|numbers.csv|tests/numbers.csv|' \
		-e 's|numbers.txt|tests/numbers.txt|' \
		-e 's|letters.csv|tests/letters.csv|' \
		tests/csv.lisp || die "sed failed for cvs.lisp"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-csv)" \
		|| die "test failed"
}
