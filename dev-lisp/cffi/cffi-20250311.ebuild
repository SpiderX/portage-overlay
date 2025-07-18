# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="48eaef6f64c2c4830f3a1104432c66e6bad721a4"

DESCRIPTION="The Common Foreign Function Interface"
HOMEPAGE="https://github.com/cffi/cffi"
SRC_URI="https://github.com/${PN}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
