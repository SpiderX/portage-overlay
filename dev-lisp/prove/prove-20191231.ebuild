# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="5d71f02795b89e36f34e8c7d50e69b67ec6ca2de"

DESCRIPTION="Yet another unit testing framework for Common Lisp"
HOMEPAGE="https://github.com/fukamachi/prove"
SRC_URI="https://github.com/fukamachi/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-ansi-text
	dev-lisp/cl-colors
	dev-lisp/cl-ppcre
	dev-lisp/split-sequence
	dev-lisp/uiop"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :prove)" \
		|| die "test failed"
}
