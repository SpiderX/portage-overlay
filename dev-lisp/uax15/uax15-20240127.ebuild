# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="2226aa32584550aa7b772cb59236eab14ac4b6d8"
MY_PN="${PN//1/-1}"
CLPACKAGE="${MY_PN}"
CLSYSTEMS="${MY_PN}"

DESCRIPTION="Common lisp implementation of unicode normalization functions"
HOMEPAGE="https://github.com/sabracrolleton/uax-15"
SRC_URI="https://github.com/sabracrolleton/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
