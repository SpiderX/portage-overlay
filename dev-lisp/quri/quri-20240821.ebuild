# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="45e0ff7f15a96ae9aef02b977375c6984d57a608"

DESCRIPTION="Yet another URI library for Common Lisp"
HOMEPAGE="https://github.com/fukamachi/quri"
SRC_URI="https://github.com/fukamachi/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/babel
	dev-lisp/cl-utilities
	dev-lisp/idna
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/prove )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :quri)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/quri
	doins -r data
}
