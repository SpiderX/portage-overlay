# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="fe3a9e66e0105c97002ccb4ec6e82f606f54760b"

DESCRIPTION="A Common Lisp data structure representing tabular data"
HOMEPAGE="https://github.com/AccelerationNet/data-table"
SRC_URI="https://github.com/AccelerationNet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-interpol
	dev-lisp/clsql
	dev-lisp/clsql-helper
	dev-lisp/collectors
	dev-lisp/iterate
	dev-lisp/symbol-munger"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lisp-unit2 )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :data-table)" \
		|| die "test failed"
}
