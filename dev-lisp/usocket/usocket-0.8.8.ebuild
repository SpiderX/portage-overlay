# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Universal socket library for Common Lisp"
HOMEPAGE="https://github.com/usocket/usocket"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # 4 out of 33 total tests failed
PROPERTIES="test_network"

RDEPEND="dev-lisp/bordeaux-threads
	dev-lisp/iolib
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :usocket)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/usocket
	doins version.sexp usocket.system
}
